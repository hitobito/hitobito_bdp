# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe Groups::SelfInscriptionController do
  let(:mitglied_role_type) { Group::Mitglieder::OrdentlicheMitgliedschaft.sti_name }
  let(:non_mitglied_role_type) { Group::Landesvorstand::EmpfaengerAufnahmeantragLVUeber18.sti_name }
  let(:mitglieder_group) { groups(:oberbayern_mauersegler_mitglieder) }
  let(:non_mitglieder_group) { groups(:bayern_landesvorstand) }

  before { sign_in(people(:mauersegler_mitglied)) }

  context "with membership role configured" do
    before do
      mitglieder_group.update!(self_registration_role_type: mitglied_role_type)
    end

    it "redirects to group with alert" do
      get :show, params: {group_id: mitglieder_group.id}
      expect(response).to redirect_to(group_path(mitglieder_group))
      expect(flash[:alert])
        .to eq("Für die Aufnahme als Mitglied muss das offizielle Aufnahmetool verwendet werden.")
    end
  end

  context "with regular role configured" do
    before do
      non_mitglieder_group.update!(self_registration_role_type: non_mitglied_role_type)
    end

    it "allows access" do
      get :show, params: {group_id: non_mitglieder_group.id}
      expect(response).not_to redirect_to(group_path(non_mitglieder_group))
    end
  end
end
