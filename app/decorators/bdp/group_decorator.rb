# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp
  module GroupDecorator
    extend ActiveSupport::Concern

    # For now, self registration is always disabled. In future it could be enabled for
    # Non-Mitglieder groups if BDP whishes to use that feature.
    def supports_self_registration?
      false
    end
  end
end
