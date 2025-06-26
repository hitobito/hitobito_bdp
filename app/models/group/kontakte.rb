# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Kontakte < ::Group
  ### ROLES

  class Adressverwaltung < ::Role
    self.permissions = [:group_and_below_full]
  end

  class Kontakt < ::Role
    self.permissions = []
  end

  roles Adressverwaltung,
    Kontakt
end
