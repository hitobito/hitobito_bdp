# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Arbeitsbereich < ::Group
  ### ROLES

  class Beauftragt < ::Role
    self.permissions = [:group_read, :contact_data]
    self.sgbviii_required = true
  end

  class AKLeitung < ::Role
    self.permissions = [:group_read, :contact_data]
    self.sgbviii_required = true
  end

  class AKMitarbeiter < ::Role
    self.permissions = [:group_read]
    self.sgbviii_required = true
  end

  class AKFreierMitarbeiter < ::Role
    self.permissions = []
  end

  roles Beauftragt,
    AKLeitung,
    AKMitarbeiter,
    AKFreierMitarbeiter
end
