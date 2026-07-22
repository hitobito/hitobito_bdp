# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe TokenAbility do
  subject(:ability) { TokenAbility.new(token) }

  let(:mitglieder_group) { groups(:oberbayern_mauersegler_mitglieder) }
  let(:stamm_group) { groups(:oberbayern_mauersegler_die_pfadfinder) }

  describe :create_membership_roles do
    context "with create_membership_roles flag" do
      let(:token) do
        Fabricate(:service_token,
          layer: groups(:root),
          permission: :layer_and_below_full,
          create_membership_roles: true)
      end

      it "may create membership roles in mitglieder group" do
        is_expected.to be_able_to(:create_membership_roles, mitglieder_group)
      end

      it "may not create membership roles in non-membership group" do
        is_expected.not_to be_able_to(:create_membership_roles, stamm_group)
      end
    end

    context "without create_membership_roles flag" do
      let(:token) do
        Fabricate(:service_token,
          layer: groups(:root),
          permission: :layer_and_below_full,
          create_membership_roles: false)
      end

      it "may not create membership roles even in mitglieder group" do
        is_expected.not_to be_able_to(:create_membership_roles, mitglieder_group)
      end
    end

    context "with layer_full permission" do
      let(:token) do
        Fabricate(:service_token,
          layer: groups(:root),
          permission: :layer_full,
          create_membership_roles: true)
      end

      it "may not create membership roles in sublayer" do
        is_expected.not_to be_able_to(:create_membership_roles, mitglieder_group)
      end
    end
  end
end
