# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Projekt < ::Group
  children Group::Bereich

  ### ROLES

  class Lagerleitung < ::Role
    self.permissions = [:group_read, :contact_data]
    self.sgbviii_required = true
  end

  class LagerleitungStv < ::Role
    self.permissions = [:group_read, :contact_data]
    self.sgbviii_required = true
  end

  class Mitarbeiter < ::Role
    self.permissions = []
    self.sgbviii_required = true
  end

  class Beauftragt < ::Role
    self.permissions = []
    self.sgbviii_required = true
  end

  class MitgliederverwaltungGrossprojekt < ::Role
    self.permissions = [:group_full]
    self.two_factor_authentication_enforced = true
  end

  class ZugriffsberechtigterMitgliederverwaltungGrossprojekt < ::Role
    self.permissions = [:layer_and_below_read]
    self.two_factor_authentication_enforced = true
  end

  roles Lagerleitung,
    LagerleitungStv,
    Mitarbeiter,
    Beauftragt,
    MitgliederverwaltungGrossprojekt,
    ZugriffsberechtigterMitgliederverwaltungGrossprojekt
end
