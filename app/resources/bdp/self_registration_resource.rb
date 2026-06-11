# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::SelfRegistrationResource
  extend ActiveSupport::Concern

  def authorize_create(model)
    super
    authorize_membership_role_creation
  end

  private

  # Membership roles are restricted by default in the core RoleAbility.
  # Users/tokens with :create_membership_roles permission get the :create
  # permission for membership roles.
  # This additional authorization check ensures that only those users/tokens
  # can create membership roles through the self-registration API.
  # As the role instance is not available yet, we create a new temporary
  # instance of the correct role type and group to check the authorization.
  def authorize_membership_role_creation
    role_class = role_type&.safe_constantize
    return unless role_class&.membership_role

    role = role_class.new(group: group)
    current_ability.authorize!(:create, role)
  end
end
