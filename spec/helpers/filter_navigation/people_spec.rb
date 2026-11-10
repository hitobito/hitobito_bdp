# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

require "spec_helper"

describe "Bdp::FilterNavigation::People" do
  include LayoutHelper
  include UtilityHelper
  include I18nHelper

  subject {
    FilterNavigation::People.new(self, group.decorate, Person::Filter::List.new(group, nil))
  }

  def can?(*_args)
    true
  end

  def role_type_ids(*role_classes)
    role_classes.collect(&:type_id).join(Person::Filter::Base::ID_URL_SEPARATOR)
  end

  def role_type_id_list(params)
    params.dig("filters", "role",
      "role_type_ids").split(Person::Filter::Base::ID_URL_SEPARATOR).collect(&:to_i)
  end

  def filter_params(url)
    Rack::Utils.parse_nested_query(URI(CGI.unescapeHTML(url)).query)
  end

  def main_item_labels
    subject.main_items.collect { |item| item[/nav-link[^>]*>(.*?)</m, 1] }
  end

  def dropdown_item(label)
    subject.dropdown.items.select { |i| i.is_a?(Dropdown::Item) }.find { |i| i.label == label }
  end

  # Simulates clicking a main item: re-renders the navigation with that item's own link as the
  # request params, the way the browser would after following it.
  def select_main_item(label)
    url = subject.main_items.find { |i| i.include?(label) }[/href="([^"]+)"/, 1]
    params = filter_params(url).with_indifferent_access
    FilterNavigation::People.new(self, group.decorate, Person::Filter::List.new(group, nil, params))
  end

  context "Group::Stamm" do
    let(:group) { groups(:oberbayern_mauersegler) }

    it "offers Stammesführung in the dropdown, scoped to the layer" do
      item = dropdown_item("Stammesführung")
      expect(item).to be_present

      params = filter_params(item.url)
      expect(params["range"]).to eq("layer")
      expect(params.dig("filters", "role", "role_type_ids")).to eq(role_type_ids(
        Group::Stamm::Stammesfuehrung,
        Group::Stamm::StammesfuehrungStv,
        Group::Stamm::Stammesschatzmeister,
        Group::Stamm::StammesschatzmeisterStv
      ))
    end

    it "offers Stammesführung (auch ehemalige) in the dropdown, for anyone who ever held " \
       "the role" do
      item = dropdown_item("Stammesführung (auch ehemalige)")
      expect(item).to be_present

      params = filter_params(item.url)
      expect(params["range"]).to eq("layer")
      expect(params.dig("filters", "role", "kind")).to eq("active")
      expect(params.dig("filters", "role", "include_archived")).to eq("true")
      expect(params.dig("filters", "role", "role_type_ids")).to eq(role_type_ids(
        Group::Stamm::Stammesfuehrung,
        Group::Stamm::StammesfuehrungStv,
        Group::Stamm::Stammesschatzmeister,
        Group::Stamm::StammesschatzmeisterStv
      ))
    end

    it "shows Funktionsträger*innen as a main pill" do
      expect(main_item_labels).to include("Funktionsträger*innen")
    end

    it "preselects Funktionsträger*innen once chosen, without also activating the dropdown" do
      selected = select_main_item("Funktionsträger*innen")
      expect(selected.active_label).to eq("Funktionsträger*innen")
      expect(selected.dropdown.active).to be_falsey
    end
  end

  context "Group::Mitglieder" do
    let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

    it "offers Mitglieder (auch ehemalige) in the dropdown, for anyone who ever held the role" do
      item = dropdown_item("Mitglieder (auch ehemalige)")
      expect(item).to be_present

      params = filter_params(item.url)
      expect(params.dig("filters", "role", "kind")).to eq("active")
      expect(params.dig("filters", "role", "include_archived")).to eq("true")
      expect(role_type_id_list(params)).to match_array([
        Group::Mitglieder::OrdentlicheMitgliedschaft,
        Group::Mitglieder::Foerdermitgliedschaft,
        Group::Mitglieder::Zweitmitgliedschaft
      ].collect(&:type_id))
    end

    it "offers Ohne Fördermitgliedschaften in the dropdown" do
      item = dropdown_item("Ohne Fördermitgliedschaften")
      expect(item).to be_present

      params = filter_params(item.url)
      expect(params.dig("filters", "role", "role_type_ids")).to eq(role_type_ids(
        Group::Mitglieder::OrdentlicheMitgliedschaft,
        Group::Mitglieder::Zweitmitgliedschaft
      ))
    end

    it "offers Nur Fördermitgliedschaften in the dropdown" do
      item = dropdown_item("Nur Fördermitgliedschaften")
      expect(item).to be_present

      params = filter_params(item.url)
      expect(params.dig("filters", "role", "role_type_ids")).to eq(role_type_ids(
        Group::Mitglieder::Foerdermitgliedschaft
      ))
    end
  end

  context "Group::Landesverband" do
    let(:group) { groups(:bayern) }
    let(:land_arbeitsbereiche) { Fabricate(Group::LandArbeitsbereiche.sti_name, parent: group) }
    let!(:land_woelflingsstufe) {
      Fabricate(Group::LandWoelflingsstufe.sti_name, parent: land_arbeitsbereiche)
    }

    it "offers Stammesführungen in the dropdown, scoped to the whole subtree" do
      item = dropdown_item("Stammesführungen")
      expect(item).to be_present

      params = filter_params(item.url)
      expect(params["range"]).to eq("deep")
      expect(params.dig("filters", "role", "role_type_ids")).to eq(role_type_ids(
        Group::Stamm::Stammesfuehrung,
        Group::Stamm::StammesfuehrungStv,
        Group::Stamm::Stammesschatzmeister,
        Group::Stamm::StammesschatzmeisterStv
      ))
    end

    it "shows Landesleitung as a main pill, including Landesbeauftragte" do
      item = subject.main_items.find { |i| i.include?("Landesleitung") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("layer")
      ids = role_type_id_list(params)
      expect(ids).to include(*[
        Group::Landesvorstand::Landesvorsitz,
        Group::Landesvorstand::LandesvorsitzStv,
        Group::Landesvorstand::Landesschatzmeister,
        Group::Landesvorstand::LandesschatzmeisterStv,
        Group::LandWoelflingsstufe::Beauftragt
      ].collect(&:type_id))
      expect(ids).not_to include(Group::LandWoelflingsstufe::AKLeitung.type_id)
    end
  end

  context "Group::Bundesebene" do
    let(:group) { groups(:root) }
    let(:bund_arbeitsbereiche) { Fabricate(Group::BundArbeitsbereiche.sti_name, parent: group) }
    let!(:bund_woelflingsstufe) {
      Fabricate(Group::BundWoelflingsstufe.sti_name, parent: bund_arbeitsbereiche)
    }

    it "shows Bundesleitung as a main pill, including Bundesbeauftragte" do
      item = subject.main_items.find { |i| i.include?("Bundesleitung") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("layer")
      ids = role_type_id_list(params)
      expect(ids).to include(*[
        Group::Bundesvorstand::Bundesvorsitz,
        Group::Bundesvorstand::BundesvorsitzStv,
        Group::Bundesvorstand::Bundesschatzmeister,
        Group::Bundesvorstand::BundesschatzmeisterStv,
        Group::BundWoelflingsstufe::Beauftragt
      ].collect(&:type_id))
      expect(ids).not_to include(Group::BundWoelflingsstufe::AKLeitung.type_id)
    end
  end

  context "Arbeitsbereiche container" do
    let(:group) { Fabricate(Group::BundArbeitsbereiche.sti_name, parent: groups(:root)) }
    let!(:woelflingsstufe) { Fabricate(Group::BundWoelflingsstufe.sti_name, parent: group) }

    it "shows Verantwortliche as a main pill with Beauftragte and Leitungen" do
      item = subject.main_items.find { |i| i.include?("Verantwortliche") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("layer")
      expect(role_type_id_list(params)).to include(
        Group::BundWoelflingsstufe::Beauftragt.type_id,
        Group::BundWoelflingsstufe::AKLeitung.type_id
      )
    end

    it "preselects Verantwortliche once chosen, without also activating the dropdown" do
      selected = select_main_item("Verantwortliche")
      expect(selected.active_label).to eq("Verantwortliche")
      expect(selected.dropdown.active).to be_falsey
    end
  end

  context "Kursteams container" do
    let(:group) { Fabricate(Group::BundKursteams.sti_name, parent: groups(:root)) }
    let!(:basiskurs) { Fabricate(Group::Basiskurs.sti_name, parent: group) }

    it "shows Verantwortliche as a main pill with Kursleiter and Kursteamer roles" do
      item = subject.main_items.find { |i| i.include?("Verantwortliche") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("layer")
      ids = role_type_id_list(params)
      expect(ids).to include(
        Group::Basiskurs::Kursleiter.type_id,
        Group::Basiskurs::Kursteamer.type_id
      )
      expect(ids).not_to include(
        Group::Basiskurs::Referent.type_id,
        Group::Basiskurs::Mitarbeiter.type_id,
        Group::Basiskurs::KursKuechenteamer.type_id
      )
    end
  end

  context "Group::Projekte" do
    let(:group) { Fabricate(Group::Projekte.sti_name, parent: groups(:root)) }

    it "shows Verantwortliche as a main pill with Leitungen und Bereichsleitungen" do
      item = subject.main_items.find { |i| i.include?("Verantwortliche") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("layer")
      expect(params.dig("filters", "role", "role_type_ids")).to eq(role_type_ids(
        Group::Projekt::Lagerleitung,
        Group::Projekt::LagerleitungStv,
        Group::Bereich::Bereichsleitung
      ))
    end
  end

  context "Group::Gruppen" do
    let(:group) { groups(:oberbayern_mauersegler_gruppen) }

    it "shows Alle Gruppenleitungen as a main pill, deep into the subtree" do
      item = subject.main_items.find { |i| i.include?("Alle Gruppenleitungen") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("deep")
      expect(params.dig("filters", "role", "role_type_ids")).to eq(role_type_ids(
        Group::StammGruppeWoelflinge::Leitung,
        Group::StammGruppeWoelflinge::Hilfsleitung,
        Group::StammGruppePfadfinder::Leitung,
        Group::StammGruppePfadfinder::Hilfsleitung,
        Group::StammGruppeRover::Leitung,
        Group::StammGruppeRover::Hilfsleitung,
        Group::StammGruppeGilde::Leitung,
        Group::StammGruppeGilde::Hilfsleitung
      ))
    end
  end

  context "Group::StammGruppeGilde" do
    let(:group) {
      Fabricate(Group::StammGruppeGilde.sti_name, parent: groups(:oberbayern_mauersegler_gruppen))
    }

    it "shows Gesamte Gilde as a main pill, deep into the subtree" do
      item = subject.main_items.find { |i| i.include?("Gesamte Gilde") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("deep")
    end
  end

  context "Intakt group" do
    let(:stamm_arbeitsbereiche) {
      Fabricate(Group::StammArbeitsbereiche.sti_name, parent: groups(:oberbayern_mauersegler))
    }
    let(:group) { Fabricate(Group::StammIntakt.sti_name, parent: stamm_arbeitsbereiche) }

    it "shows Alle Intakt-Bereiche as a main pill, deep into the subtree" do
      item = subject.main_items.find { |i| i.include?("Alle Intakt-Bereiche") }
      expect(item).to be_present

      params = filter_params(item[/href="([^"]+)"/, 1])
      expect(params["range"]).to eq("deep")
    end
  end
end
