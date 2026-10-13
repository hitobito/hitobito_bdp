# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

# Hides all self registration UI. Groups::PeopleManagers accept self registrations
# via the API only, so their self registration link must not be shown either.
module Bdp::GroupDecorator
  extend ActiveSupport::Concern

  def supports_self_registration?
    false
  end

  def self_registration_active?
    false
  end
end
