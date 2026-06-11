# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe SelfRegistrationResource, type: :resource do
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

  let(:payload) do
    {
      data: {
        type: "people",
        attributes: {
          first_name: "Test",
          last_name: "User",
          email: "test@example.com",
          privacy_policy_accepted: true
        }
      }
    }
  end

  let(:instance) { SelfRegistrationResource.build(payload) }

  describe "creating membership role" do
    before do
      allow(context).to receive(:group).and_return(groups(:oberbayern_mauersegler_mitglieder))
      groups(:oberbayern_mauersegler_mitglieder).update!(
        self_registration_role_type: Group::Mitglieder::OrdentlicheMitgliedschaft.sti_name
      )
    end

    context "service token with create_membership_roles scope" do
      let(:person) { service_token(create_membership_roles: true).dynamic_user }

      it "allows creating person with membership role" do
        expect {
          expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
        }.to change { Person.count }.by(1)
          .and change { Role.count }.by(1)
      end
    end

    context "service token without create_membership_roles scope" do
      let(:person) { service_token(create_membership_roles: false).dynamic_user }

      it "raises CanCan::AccessDenied" do
        expect { instance.save }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "user with create_membership_roles permission" do
      let(:person) { people(:admin) }

      it "allows creating person with membership role" do
        expect {
          expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
        }.to change { Person.count }.by(1)
          .and change { Role.count }.by(1)
      end
    end

    context "user without create_membership_roles permission" do
      let(:person) { people(:bund_layer_and_below_full) }

      it "raises CanCan::AccessDenied" do
        expect { instance.save }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "creating regular role" do
    let(:person) { people(:bund_layer_and_below_full) }

    before do
      allow(context).to receive(:group).and_return(groups(:bayern_landesvorstand))
      groups(:bayern_landesvorstand).update!(
        self_registration_role_type:
          Group::Landesvorstand::EmpfaengerAufnahmeantragLVUeber18.sti_name
      )
    end

    it "allows creating person with regular role" do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Person.count }.by(1)
        .and change { Role.count }.by(1)
    end
  end
end
