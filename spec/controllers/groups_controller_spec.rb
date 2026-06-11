# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe GroupsController do
  let(:group) { groups(:oberbayern_mauersegler_mitglieder) }
  let(:user) { people(:mauersegler_mitgliederverwalter) }

  describe "PUT update" do
    before { sign_in(user) }

    Group::Mitglieder.roles.select(&:membership_role).each do |membership_role_type|
      it "can update self_registration_role_type to #{membership_role_type}" do
        patch :update, params: {id: group.id, group: {
          self_registration_role_type: membership_role_type.sti_name
        }}

        expect(group.reload.self_registration_role_type).to eq membership_role_type.sti_name
      end
    end
  end
end
