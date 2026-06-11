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

      it "make sure our test user has the expected permission" do
        expect(user.roles)
          .to include(have_attributes(permissions: include(:create_membership_roles)))
      end

      it "can create membership_role roles" do
        is_expected.to be_able_to(:create, membership_role)
      end

      it "can show membership_role roles" do
        is_expected.to be_able_to(:show, membership_role)
      end

      it "can update membership_role roles" do
        is_expected.to be_able_to(:update, membership_role)
      end

      it "can destroy membership_role roles" do
        is_expected.to be_able_to(:destroy, membership_role)
      end
    end

    context "as non-admin with layer_and_below_full permission" do
      let(:user) { people(:mauersegler_mitgliederverwalter) }

      it "make sure our test user does not have the required permission" do
        expect(user.roles)
          .not_to include(have_attributes(permissions: include(:create_membership_roles)))
      end

      it "cannot create membership_role roles" do
        is_expected.not_to be_able_to(:create, membership_role)
      end

      it "can show membership_role roles in same layer" do
        is_expected.to be_able_to(:show, membership_role)
      end

      it "can update membership_role roles in same layer" do
        is_expected.to be_able_to(:update, membership_role)
      end

      it "can destroy membership_role roles in same layer" do
        is_expected.to be_able_to(:destroy, membership_role)
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

  context "non-restricted roles" do
    let(:stamm_group) { groups(:oberbayern_mauersegler_die_pfadfinder) }

    context "as non-admin with layer_and_below_full permission" do
      let(:user) { people(:mauersegler_mitgliederverwalter) }
      let(:regular_role) { roles(:mauersegler_mitglied_pfadfinder) }

      it "can create non-restricted roles in same layer" do
        is_expected.to be_able_to(:create, regular_role)
      end

      it "can show non-restricted roles in same layer" do
        is_expected.to be_able_to(:show, regular_role)
      end

      it "can update non-restricted roles in same layer" do
        is_expected.to be_able_to(:update, regular_role)
      end

      it "can destroy non-restricted roles in same layer" do
        is_expected.to be_able_to(:destroy, regular_role)
      end
    end

    context "as user without full permissions" do
      let(:user) { people(:mauersegler_mitglied2) }
      let(:role) { roles(:mauersegler_mitglied_pfadfinder) }

      it "cannot create non-restricted roles of another person" do
        is_expected.not_to be_able_to(:create, role)
      end
    end
  end
end
