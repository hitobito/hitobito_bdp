# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe "self_registrations#create", type: :request do
  let(:stamm) { groups(:oberbayern_mauersegler) }
  let(:group) { Group::PeopleManagers.create!(parent: stamm) }
  let(:service_token) do
    Fabricate(:service_token, layer: stamm, permission: :layer_and_below_full,
      register_people: true)
  end
  let(:token) { service_token.token }

  let(:payload) do
    {
      data: {
        type: "self_registrations",
        attributes: {
          first_name: "Erika",
          last_name: "Muster",
          email: "erika.muster@hitobito.example.com"
        }
      }
    }
  end

  subject(:make_request) do
    jsonapi_post "/api/groups/#{group.id}/self_registrations", payload
  end

  context "with service token" do
    def jsonapi_headers
      super.merge("X-TOKEN" => token)
    end

    it "registers the person as parent" do
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Person.count }.by(1)

      person = Person.find_by(email: "erika.muster@hitobito.example.com")
      expect(person.roles.map(&:type)).to eq [Group::PeopleManagers::Kontakt.sti_name]
      expect(person.roles.first.group).to eq group
    end

    it "is forbidden without register_people scope" do
      service_token.update!(register_people: false)

      expect {
        make_request
        expect(response.status).to eq(403), response.body
      }.not_to change { Person.count }
    end

    it "is forbidden for a group outside of the token layer" do
      service_token.update!(layer: groups(:bayern), permission: :layer_full)

      expect {
        make_request
        expect(response.status).to eq(403), response.body
      }.not_to change { Person.count }
    end
  end

  context "with session cookie" do
    before { sign_in(people(:mauersegler_mitglied)) }

    it "is forbidden, self registration is only ever permitted via an API token" do
      expect {
        make_request
        expect(response.status).to eq(403), response.body
      }.not_to change { Person.count }
    end

    context "on another group with a self registration role type" do
      let(:group) do
        groups(:oberbayern_mauersegler_mitglieder).tap do |g|
          g.update!(self_registration_role_type:
            Group::Mitglieder::OrdentlicheMitgliedschaft.sti_name)
        end
      end

      it "is forbidden" do
        expect {
          make_request
          expect(response.status).to eq(403), response.body
        }.not_to change { Person.count }
      end
    end
  end
end
