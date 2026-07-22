# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe Group do
  let(:group) { groups(:oberbayern_mauersegler_mitglieder) }
  let(:mitglied_role_class) { Group::Mitglieder::OrdentlicheMitgliedschaft }

  describe "#self_registration_active?" do
    it "always returns false" do
      # Prepare the group so that core #self_registration_active? would return true
      # The groups allowed_roles_for_self_registration must include the groups
      # self_registration_role_type
      expect(group.decorate.allowed_roles_for_self_registration)
        .to include(mitglied_role_class)
      group.self_registration_role_type = mitglied_role_class.sti_name

      expect(group).not_to be_self_registration_active
    end
  end
end
