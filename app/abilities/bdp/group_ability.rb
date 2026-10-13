# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::GroupAbility
  extend ActiveSupport::Concern

  private

  # Self registration, including for Group::PeopleManagers (parents), is only ever permitted
  # via an authenticated API token (see TokenAbility), never through a session cookie.
  def in_self_registration_groups
    false
  end
end
