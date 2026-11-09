# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

require "spec_helper"

describe "Dropdown::ExternalMembershipActions" do
  include FormatHelper
  include LayoutHelper
  include UtilityHelper

  let(:person) { people(:mauersegler_mitglied) }
  let(:current_user) { person }
  let(:full_access_abilities) { [] }
  let(:group) { nil }
  let(:dropdown) { Dropdown::ExternalMembershipActions.new(self, person, group) }

  subject { Capybara::Node::Simple.new(dropdown.to_s) }

  def can?(ability, subject_person)
    subject_person == current_user ||
      current_user&.manageds&.include?(subject_person) ||
      full_access_abilities.include?(ability)
  end

  def menu
    subject.find(".btn-group > ul.dropdown-menu")
  end

  def menu_entries
    menu.all("> li > a").map(&:text)
  end

  def link_for(label)
    menu.find("> li > a", text: label)
  end

  around do |example|
    original_person = Settings.external_actions.person.to_hash.dup
    original_person_full = Settings.external_actions.person_full.to_hash.dup
    example.run
    Settings.external_actions.person.merge!(original_person)
    Settings.external_actions.person_full.merge!(original_person_full)
  end

  before do
    Settings.external_actions.person.mitgliedsbescheinigung_url = "https://normal.example.com/mitgliedsbescheinigung"
    Settings.external_actions.person.austritt_url = "https://normal.example.com/austritt?personId=%{person_id}"
    Settings.external_actions.person.stammeswechsel_url =
      "https://normal.example.com/stammeswechsel?personId=%{person_id}&groupId=%{group_id}&layerId=%{layer_id}"
    Settings.external_actions.person.zweitmitgliedschaft_url = "https://normal.example.com/zweitmitgliedschaft"
    Settings.external_actions.person.mitgliedsart_url = "https://normal.example.com/mitgliedsart"

    Settings.external_actions.person_full.mitgliedsbescheinigung_url =
      "https://full.example.com/select?reportId=mitgliedsbescheinigung&personId=%{person_id}"
    Settings.external_actions.person_full.austritt_url = "https://full.example.com/austritt?personId=%{person_id}"
    Settings.external_actions.person_full.stammeswechsel_url = "https://full.example.com/stammeswechsel"
    Settings.external_actions.person_full.zweitmitgliedschaft_url = "https://full.example.com/zweitmitgliedschaft"
    Settings.external_actions.person_full.mitgliedsart_url = "https://full.example.com/mitgliedsart"
  end

  shared_examples "normal access" do
    it "renders all items with the normal titles and urls, templated with the person id" do
      expect(menu_entries).to match_array(
        ["Mitgliedsbescheinigung", "Austritt erklären", "Stamm wechseln",
          "Zweitmitgliedschaft beantragen", "Mitgliedsart wechseln"]
      )

      link = link_for("Austritt erklären")
      expect(link[:href]).to eq "https://normal.example.com/austritt?personId=#{person.id}"
      expect(link[:target]).to eq "_blank"

      link = link_for("Mitgliedsbescheinigung")
      expect(link[:href]).to eq "https://normal.example.com/mitgliedsbescheinigung"
    end

    context "with a current group" do
      let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

      it "also templates the group id and its layer id into urls that reference them" do
        link = link_for("Stamm wechseln")
        expect(link[:href]).to eq(
          "https://normal.example.com/stammeswechsel?personId=#{person.id}" \
          "&groupId=#{group.id}&layerId=#{group.layer_group_id}"
        )
      end
    end

    context "without a current group" do
      it "leaves a url's group and layer id placeholders blank" do
        link = link_for("Stamm wechseln")
        expect(link[:href]).to eq "https://normal.example.com/stammeswechsel?personId=#{person.id}&groupId=&layerId="
      end
    end
  end

  context "viewing their own profile" do
    let(:current_user) { person }

    include_examples "normal access"
  end

  context "a registered manager of the person" do
    let(:current_user) { people(:admin) }

    before { PeopleManager.create!(manager: current_user, managed: person) }

    include_examples "normal access"
  end

  context "neither self nor manager" do
    let(:current_user) { people(:admin) }

    context "without any full-access ability" do
      it "renders nothing" do
        expect(dropdown.to_s).to eq ""
      end
    end

    context "with only show_full" do
      let(:full_access_abilities) { [:show_full] }

      it "renders only the certificate, with the full-access title and a templated url" do
        expect(menu_entries).to eq ["Mitgliedsbescheinigung"]

        link = link_for("Mitgliedsbescheinigung")
        expect(link[:href]).to eq "https://full.example.com/select?reportId=mitgliedsbescheinigung&personId=#{person.id}"
      end
    end

    context "with update" do
      let(:full_access_abilities) { [:show_full, :update] }

      it "renders all items with the full-access titles and urls" do
        expect(menu_entries).to match_array(
          ["Mitgliedsbescheinigung", "Austritt erfassen", "Stammwechsel initieren",
            "Zweitmitgliedschaft hinzufügen", "Mitgliedsart ändern"]
        )

        link = link_for("Austritt erfassen")
        expect(link[:href]).to eq "https://full.example.com/austritt?personId=#{person.id}"

        link = link_for("Mitgliedsbescheinigung")
        expect(link[:href]).to eq "https://full.example.com/select?reportId=mitgliedsbescheinigung&personId=#{person.id}"
      end
    end
  end

  context "person without an active membership role" do
    let(:person) { people(:leader) }
    let(:full_access_abilities) { [:show_full, :update] }

    it "renders nothing, even when viewing their own profile" do
      expect(dropdown.to_s).to eq ""
    end
  end
end
