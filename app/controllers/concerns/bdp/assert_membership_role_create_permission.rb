# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::AssertMembershipRoleCreatePermission
  # Check if the current user has permission to create membership roles.
  # Membership roles are special roles on which :create is only granted
  # if the user has a role with :create_membership_roles permission.
  def assert_membership_role_create_permission
    role_type = group.self_registration_role_type&.safe_constantize
    return unless role_type&.membership_role

    if current_ability.nil? || !current_ability.can?(:create, wizard.role)
      redirect_to group_path(group),
        alert: t("groups.self_registration.alert.membership_role_not_allowed")
    end
  end
end
