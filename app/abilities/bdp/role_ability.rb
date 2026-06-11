# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::RoleAbility
  extend ActiveSupport::Concern

  prepended do
    on(Role) do
      # Override the Core's general.non_restricted rule so we can customize
      # the rules. We generally allow non-restricted roles and membership roles.
      general.non_restricted_or_membership_role

      # Override Core's general(:create) to add check for membership_role roles.
      # Only users/tokens with :create_membership_roles permission can create
      # membership roles.
      general(:create).non_restricted_or_admin_and_group_active
    end
  end

  def non_restricted_or_admin_and_group_active
    group_not_deleted_or_archived && non_restricted_or_admin
  end

  def non_restricted_or_admin
    !subject.restricted? ||
      (can_create_membership_roles? && subject.membership_role)
  end

  def non_restricted_or_membership_role
    !subject.restricted? || subject.membership_role
  end

  def can_create_membership_roles?
    user_context.all_permissions.include?(:create_membership_roles)
  end
end
