# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::BundesArbeitsbereich < ::Group
  ### ROLES

  class BundesBeauftragt < ::Role
    self.permissions = [:group_read, :contact_data]
  end

  class AKLeitung < ::Role
    self.permissions = [:group_read, :contact_data]
  end

  class AKMitarbeiter < ::Role
    self.permissions = [:group_read]
  end

  class AKFreierMitarbeiter < ::Role
    self.permissions = []
  end

  roles BundesBeauftragt,
    AKLeitung,
    AKMitarbeiter,
    AKFreierMitarbeiter
end
