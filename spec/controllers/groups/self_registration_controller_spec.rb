# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe Groups::SelfRegistrationController do
  let(:group) { Group::PeopleManagers.create!(parent: groups(:oberbayern_mauersegler)) }

  it "redirects to the group although self registration is active for the API" do
    expect(group).to be_self_registration_active

    get :show, params: {group_id: group.id}

    expect(response).to redirect_to(group_path(group))
    expect(flash[:alert]).to eq I18n.t("groups.self_registration.alert.not_active")
  end

  it "does not register a person" do
    expect {
      post :create, params: {
        group_id: group.id,
        wizards_register_new_user_wizard: {
          main_email_field: {email: "erika.muster@hitobito.example.com"}
        }
      }
    }.not_to change { Person.count }

    expect(response).to redirect_to(group_path(group))
  end
end
