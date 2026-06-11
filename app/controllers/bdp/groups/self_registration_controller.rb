# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::Groups::SelfRegistrationController
  extend ActiveSupport::Concern
  include Bdp::AssertMembershipRoleCreatePermission

  # Membership roles must not be created via self-registration.
  # They can only be created through the official admission tool.
  # We want the check to happen before the redirect to self-inscription
  # but after the other before actions, so we override this method.
  def redirect_to_group_if_necessary
    assert_membership_role_create_permission || super
  end
end
