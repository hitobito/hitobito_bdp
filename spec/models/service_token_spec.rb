# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe ServiceToken do
  let(:service_token) {
    ServiceToken.new(layer: groups(:root), permission: :layer_and_below_full)
  }

  context "with create_membership_roles flag" do
    it "includes :create_membership_roles permission in dynamic user" do
      service_token.create_membership_roles = true
      dynamic_user = service_token.dynamic_user
      expect(dynamic_user.roles.first.permissions).to include(:create_membership_roles)
    end
  end

  context "without create_membership_roles flag" do
    it "does not include :create_membership_roles permission in dynamic user" do
      service_token.create_membership_roles = false
      dynamic_user = service_token.dynamic_user
      expect(dynamic_user.roles.first.permissions).not_to include(:create_membership_roles)
    end
  end
end
