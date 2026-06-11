# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::ServiceToken
  extend ActiveSupport::Concern

  def dynamic_user
    super.tap do |p|
      p.roles.first.permissions << :create_membership_roles if create_membership_roles?
    end
  end
end
