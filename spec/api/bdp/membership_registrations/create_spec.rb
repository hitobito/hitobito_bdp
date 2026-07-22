# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe "bdp/membership_registrations#create", type: :request do
  let(:group) { groups(:oberbayern_mauersegler_mitglieder) }
  let(:service_token) do
    Fabricate(:service_token,
      layer: groups(:root),
      permission: :layer_and_below_full,
      register_people: true,
      create_membership_roles: true)
  end
  let(:token) { service_token.token }

  let(:payload) do
    {
      data: {
        type: "membership_registrations",
        attributes: attributes
      }
    }
  end

  let(:attributes) do
    {
      first_name: "John",
      last_name: "Doe",
      email: "test-member@example.com",
      group_id: group.id,
      role_type: Group::Mitglieder::OrdentlicheMitgliedschaft.name
    }
  end

  subject(:make_request) do
    jsonapi_post "/api/membership_registrations", payload,
      headers: {"X-TOKEN" => token}
  end

  context "with OrdentlicheMitgliedschaft" do
    it "creates a person with the selected membership role" do
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Person.count }.by(1).and change { Role.count }.by(1)

      expect(Person.last).to have_attributes(first_name: "John", last_name: "Doe")
      expect(Role.last).to be_a(Group::Mitglieder::OrdentlicheMitgliedschaft)
      expect(Role.last.group).to eq(group)
    end
  end

  context "with Foerdermitgliedschaft" do
    let(:attributes) do
      super().merge(role_type: Group::Mitglieder::Foerdermitgliedschaft.name)
    end

    before do
      FeeKind.create!(layer: groups(:root),
        role_type: Group::Mitglieder::Foerdermitgliedschaft.name,
        name: "Fördermitgliedschaft Default",
        restricted: false)
    end

    it "creates a person with the selected membership role" do
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Person.count }.by(1).and change { Role.count }.by(1)

      expect(Role.last).to be_a(Group::Mitglieder::Foerdermitgliedschaft)
    end
  end

  context "with invalid role type" do
    let(:attributes) do
      super().merge(role_type: Group::Mitglieder::Zweitmitgliedschaft.name)
    end

    it "returns 400 invalid request" do
      expect {
        make_request
        expect(response.status).to eq(400), response.body
      }.not_to change { [Person.count, Role.count] }
    end
  end

  context "without role type" do
    let(:attributes) do
      super().except(:role_type)
    end

    it "returns 400 invalid request" do
      expect {
        make_request
        expect(response.status).to eq(400), response.body
      }.not_to change { [Person.count, Role.count] }
    end
  end

  context "without group_id" do
    let(:attributes) do
      super().except(:group_id)
    end

    it "returns 400 invalid request" do
      expect {
        make_request
        expect(response.status).to eq(400), response.body
      }.not_to change { [Person.count, Role.count] }
    end
  end

  context "with missing register_people token permission" do
    before { service_token.update!(register_people: false) }

    it "returns 403 forbidden" do
      expect {
        make_request
        expect(response.status).to eq(403), response.body
      }.not_to change { [Person.count, Role.count] }
    end
  end

  context "with missing create_membership_roles token permission" do
    before { service_token.update!(create_membership_roles: false) }

    it "returns 403 forbidden" do
      expect {
        make_request
        expect(response.status).to eq(403), response.body
      }.not_to change { [Person.count, Role.count] }
    end
  end

  context "with missing write permission" do
    before { service_token.update!(permission: :layer_and_below_read) }

    it "returns 403 forbidden" do
      expect {
        make_request
        expect(response.status).to eq(403), response.body
      }.not_to change { [Person.count, Role.count] }
    end
  end

  context "with non-member group" do
    let(:group) { groups(:oberbayern_mauersegler) }

    it "returns 403 forbidden" do
      expect {
        make_request
        expect(response.status).to eq(403), response.body
      }.not_to change { [Person.count, Role.count] }
    end
  end
end
