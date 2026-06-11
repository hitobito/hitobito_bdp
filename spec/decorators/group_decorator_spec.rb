# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe GroupDecorator, :draper_with_helpers do
  describe "::all_allowed_roles_for_self_registration" do
    it "includes membership roles" do
      membership_roles = [
        Group::Mitglieder::OrdentlicheMitgliedschaft,
        Group::Mitglieder::Foerdermitgliedschaft,
        Group::Mitglieder::Zweitmitgliedschaft
      ]

      expect(GroupDecorator.all_allowed_roles_for_self_registration)
        .to include(*membership_roles)
    end
  end

  describe "#allowed_roles_for_self_registration" do
    let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

    subject(:decorator) { group.decorate }

    it "includes OrdentlicheMitgliedschaft (membership_role)" do
      expect(Group::Mitglieder::OrdentlicheMitgliedschaft.membership_role).to eq true
      expect(Group::Mitglieder::OrdentlicheMitgliedschaft).to be_restricted
      expect(decorator.allowed_roles_for_self_registration)
        .to include(Group::Mitglieder::OrdentlicheMitgliedschaft)
    end
  end

  describe "#possible_roles" do
    let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

    subject(:decorator) { group.decorate }

    before { allow(decorator.helpers).to receive(:action_name).and_return("new") }

    context "user without create_membership_roles permission" do
      let(:current_user) { people(:mauersegler_mitgliederverwalter) }

      it "does not include membership roles" do
        expect(decorator.possible_roles)
          .not_to include(Group::Mitglieder::OrdentlicheMitgliedschaft)
      end
    end

    context "user with create_membership_roles permission" do
      let(:current_user) { people(:admin) }

      it "includes membership roles" do
        expect(decorator.possible_roles).to include(Group::Mitglieder::OrdentlicheMitgliedschaft)
      end
    end
  end
end
