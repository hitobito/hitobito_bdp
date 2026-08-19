# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

module Bdp
  module PersonDecorator
    extend ActiveSupport::Concern

    # Show the membership group instead of town/birth year in person picker labels.
    def full_label
      label = to_s
      if company?
        name = full_name
        label << " (#{name})" if name.present?
      elsif person.layer_group
        label << " (#{person.layer_group})"
      end
      label
    end
  end
end
