# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

namespace :app do
  namespace :license do
    task :config do # rubocop:disable Rails/RakeEnvironment
      @licenser = Licenser.new("hitobito_bdp",
        "Bund der Pfadfinderinnen und Pfadfinder e.V.",
        "https://github.com/hitobito/hitobito_bdp")
    end
  end
end
