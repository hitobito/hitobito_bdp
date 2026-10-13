# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe Groups::SelfInscriptionController do
  let(:group) { Group::PeopleManagers.create!(parent: groups(:oberbayern_mauersegler)) }
  let(:person) { people(:mauersegler_mitglied) }

  before { sign_in(person) }

  it "redirects to the person although self registration is active for the API" do
    expect(group).to be_self_registration_active

    get :show, params: {group_id: group.id}

    expect(response).to redirect_to(group_person_path(person.default_group_id, person))
    expect(flash[:alert]).to eq I18n.t("groups.self_inscription.show.disabled")
  end
end
