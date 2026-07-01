# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe JsonApi::SelfRegistrationsController, type: [:request] do
  let(:mitglied_role_type) { Group::Mitglieder::OrdentlicheMitgliedschaft.sti_name }
  let(:non_mitglied_role_type) { Group::Landesvorstand::EmpfaengerAufnahmeantragLVUeber18.sti_name }
  let(:mitglieder_group) { groups(:oberbayern_mauersegler_mitglieder) }
  let(:non_mitglieder_group) { groups(:bayern_landesvorstand) }
  let(:params) { {} }

  def create_token(**opts)
    Fabricate(:service_token,
              **opts.reverse_merge(
                layer: groups(:root),
                permission: :layer_and_below_full,
                groups: true,
                people: true,
                register_people: true
              )).token
  end

  def payload(**opts)
    opts.reverse_merge(
      data: {
        type: "people",
        attributes: {
          first_name: "Test",
          last_name: "User",
          email: "test@example.com",
          privacy_policy_accepted: true,
          fee_kind_id: fee_kinds(:bayern_kind).id
        }
      }
    )
  end

  context "with membership role configured" do
    before do
      mitglieder_group.update!(self_registration_role_type: mitglied_role_type)
    end

    context "service token without create_membership_roles scope" do
      it "returns forbidden" do
        token = create_token(create_membership_roles: false)

        jsonapi_post "/api/groups/#{mitglieder_group.id}/self_registrations", payload(token:)
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "service token with create_membership_roles scope" do
      it "allows access" do
        token = create_token(create_membership_roles: true)

        jsonapi_post "/api/groups/#{mitglieder_group.id}/self_registrations", payload(token:)
        expect(response).to have_http_status(:created)
      end
    end

    context "user without create_membership_roles permission" do
      it "returns forbidden" do
        sign_in(people(:mauersegler_mitglied))
        allow_any_instance_of(described_class).to receive(:user_session?).and_return(true)

        jsonapi_post "/api/groups/#{mitglieder_group.id}/self_registrations", payload
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "user with create_membership_roles permission" do
      it "allows access" do
        sign_in(people(:admin))

        jsonapi_post "/api/groups/#{mitglieder_group.id}/self_registrations", payload
        expect(response).to have_http_status(:created)
      end
    end
  end

  context "with regular role configured" do
    before do
      non_mitglieder_group.update!(self_registration_role_type: non_mitglied_role_type)
    end

    context "service tokene" do
      it "allows access" do
        token = create_token

        jsonapi_post "/api/groups/#{non_mitglieder_group.id}/self_registrations", payload(token:)
        expect(response).to have_http_status(:created)
      end
    end
  end
end
