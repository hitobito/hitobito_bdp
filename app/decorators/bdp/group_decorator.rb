# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::GroupDecorator
  extend ActiveSupport::Concern

  prepended do
    # Override class method directly on singleton class since prepend doesn't work for class methods
    # First alias the original method so we can call it
    GroupDecorator.singleton_class.alias_method :core_all_allowed_roles_for_self_registration,
      :all_allowed_roles_for_self_registration

    GroupDecorator.define_singleton_method(:all_allowed_roles_for_self_registration) do
      # This method is used for the Group.self_registration_active scope which lists
      # all groups with self-registration enabled.
      # Membership roles can only be used for self-registration with the api which
      # calls the scope to filter groups with self-registration enabled.
      core_all_allowed_roles_for_self_registration + Role.all_types.select(&:membership_role)
    end
  end

  # Include membership roles in the list of roles allowed for self-registration
  # for this specific group. This allows admins to configure membership roles
  # as the self-registration role type.
  def allowed_roles_for_self_registration
    super + role_types.select(&:membership_role)
  end

  # Override to include membership roles when user has permission to create membership roles.
  # This ensures that users with the appropriate permission can assign membership roles
  # to people through the UI.
  def possible_roles(person: Person.new)
    super + possible_membership_roles(person:)
  end

  def possible_membership_roles(person:)
    role_types.select(&:membership_role)
      .select { |r| can?(:create, r.new(person:, group: model)) }
  end
end
