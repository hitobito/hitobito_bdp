# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe GroupsController do
  context "with people managers group" do
    render_views

    let(:group) { Group::PeopleManagers.create!(parent: groups(:oberbayern_mauersegler)) }
    let(:user) { people(:mauersegler_mitgliederverwalter) }

    before { sign_in(user) }

    it "GET show does not render the self registration link" do
      get :show, params: {id: group.id}

      expect(response.body).not_to include(group_self_registration_path(group))
    end

    it "GET edit does not render the self registration tab" do
      get :edit, params: {id: group.id}

      expect(response.body).not_to include("self_registration_role_type")
    end
  end
end
