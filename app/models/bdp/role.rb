# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::Role
  extend ActiveSupport::Concern

  prepended do
    # Marks a role as a membership role.
    # Membership roles are special roles that can only be created by users
    # or service tokens with explicit :create_membership_roles permission.
    # They are meant to get created by the official admission tool using the api.
    class_attribute :membership_role, default: false
  end
end
