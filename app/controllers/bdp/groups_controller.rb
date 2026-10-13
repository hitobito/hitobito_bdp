# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

# Self registration is only ever enabled automatically, for Group::PeopleManagers, see
# Bdp::Group::PeopleManagers. It must not be settable through the group form either, on any
# group, even though Bdp::GroupDecorator already hides the form field everywhere.
module Bdp::GroupsController
  extend ActiveSupport::Concern

  def permitted_attrs
    super - [:self_registration_role_type]
  end
end
