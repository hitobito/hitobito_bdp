# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp::Group::PeopleManagers
  extend ActiveSupport::Concern

  prepended do
    before_validation :assign_self_registration_role_type
  end

  private

  def assign_self_registration_role_type
    self.self_registration_role_type = ::Group::PeopleManagers::Kontakt.sti_name
  end
end
