# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe Bdp::MembershipRegistrationResource, type: :resource do
  def service_token(**opts)
    Fabricate(:service_token,
      opts.reverse_merge(
        layer: groups(:root),
        permission: :layer_and_below_full,
        groups: true,
        people: true,
        register_people: true
      ))
  end

  let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

  let(:payload) do
    {
      data: {
        type: "membership_registrations",
        attributes: {
          first_name: "Test",
          last_name: "User",
          email: "test@example.com",
          group_id: group.id,
          role_type: Group::Mitglieder::OrdentlicheMitgliedschaft.sti_name
        }
      }
    }
  end

  let(:instance) { Bdp::MembershipRegistrationResource.build(payload) }

  describe "creating membership role" do
    context "with create_membership_roles scope" do
      let(:token) { service_token(create_membership_roles: true) }
      let(:ability) { TokenAbility.new(token) }

      it "creates person with membership role" do
        expect {
          expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
        }.to change { Person.count }.by(1)
          .and change { Role.count }.by(1)
      end
    end

    context "without create_membership_roles scope" do
      let(:token) { service_token(create_membership_roles: false) }
      let(:ability) { TokenAbility.new(token) }

      it "raises CanCan::AccessDenied" do
        expect { instance.save }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
