# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Mitglieder < ::Group
  ### ROLES

  class OrdentlicheMitgliedschaft < ::Role
    self.permissions = []
  end

  class Foerdermitgliedschaft < ::Role
    self.permissions = []
  end

  class Zweitmitgliedschaft < ::Role
    self.permissions = []
  end

  roles OrdentlicheMitgliedschaft,
    Foerdermitgliedschaft,
    Zweitmitgliedschaft
end
