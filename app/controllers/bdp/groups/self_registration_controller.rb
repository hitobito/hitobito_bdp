# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::Groups::SelfRegistrationController
  extend ActiveSupport::Concern
  include Bdp::MissingMembershipRoleCreatePermission

  private

  # Self registration is only possible via the API in BdP, see Bdp::Group::PeopleManagers.
  def assert_self_registration_active
    redirect_to group_path(group), alert: I18n.t("groups.self_registration.alert.not_active")
  end
end
