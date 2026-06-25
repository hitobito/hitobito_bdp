# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::MissingMembershipRoleCreatePermission
  def redirect_to_group_if_necessary
    if missing_membership_role_create_permission?(wizard.role)
      return redirect_to group_path(group),
        alert: t("groups.self_registration.alert.membership_role_not_allowed")
    end
    super
  end

  def missing_membership_role_create_permission?(role)
    return false unless role&.membership_role

    !current_ability&.can?(:create, role)
  end
end
