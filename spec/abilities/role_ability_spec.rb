# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe RoleAbility do
  subject(:ability) { Ability.new(user) }

  let(:person) { people(:mauersegler_mitglied) }
  let(:mitglieder_group) { groups(:oberbayern_mauersegler_mitglieder) }
  let(:stamm_group) { groups(:oberbayern_mauersegler_die_pfadfinder) }

  context "membership_role roles" do
    let(:membership_role) { roles(:mauersegler_mitglied_ordentliche_mitgliedschaft) }

    context "as admin with :create_membership_roles" do
      let(:user) { people(:admin) }

      before do
        # make sure our test user has the expected permission
        expect(ability.user_context.all_permissions).to include(:create_membership_roles)
      end

      %i[create show update destroy].each do |action|
        it "can #{action} membership_role roles" do
          is_expected.to be_able_to(action, membership_role)
        end
      end
    end

    context "as non-admin with layer_and_below_full permission" do
      let(:user) { people(:mauersegler_mitgliederverwalter) }

      before do
        # make sure our test user has the expected permission
        expect(ability.user_context.all_permissions).not_to include(:create_membership_roles)
        expect(ability.user_context.permission_layer_ids(:layer_and_below_full))
          .to include(membership_role.group.layer_group_id)
      end

      it "cannot create membership_role roles" do
        is_expected.not_to be_able_to(:create, membership_role)
      end

      %i[show update destroy].each do |action|
        it "can #{action} membership_role roles in same layer" do
          is_expected.to be_able_to(action, membership_role)
        end
      end
    end

    context "as user without full permissions" do
      let(:user) { people(:mauersegler_mitglied2) }

      it "cannot create membership_role roles in different group" do
        is_expected.not_to be_able_to(:create, membership_role)
      end

      it "cannot show membership_role roles of another person in different group" do
        is_expected.not_to be_able_to(:show, membership_role)
      end
    end
  end

  context "regular roles" do
    let(:stamm_group) { groups(:oberbayern_mauersegler_die_pfadfinder) }

    context "as non-admin with layer_and_below_full permission" do
      let(:user) { people(:mauersegler_mitgliederverwalter) }
      let(:regular_role) { roles(:mauersegler_mitglied_pfadfinder) }

      %i[create show update destroy].each do |action|
        it "can #{action} regular roles in same layer" do
          is_expected.to be_able_to(action, regular_role)
        end
      end
    end

    context "as user without full permissions" do
      let(:user) { people(:mauersegler_mitglied2) }
      let(:role) { roles(:mauersegler_mitglied_pfadfinder) }

      it "cannot create regular roles of another person" do
        is_expected.not_to be_able_to(:create, role)
      end
    end
  end
end
