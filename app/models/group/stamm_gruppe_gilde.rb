# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::StammGruppeGilde < ::Group
  children Group::StammGruppePfadfinder

  ### ROLES

  class Leitung < ::Role
    self.permissions = [:group_and_below_read]
    self.sgbviii_required = true
  end

  class Hilfsleitung < ::Role
    self.permissions = [:group_and_below_read]
    self.sgbviii_required = true
  end

  roles Leitung, Hilfsleitung
end
