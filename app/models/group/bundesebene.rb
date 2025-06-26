# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Bundesebene < ::Group
  self.layer = true

  children Group::Bundesvorstand,
    Group::Bundesgeschaeftsstelle,
    Group::Ombudsrat,
    Group::Betrieb,
    Group::Versammlung,
    Group::Projekt,
    Group::Kontakte,
    Group::Mitglieder,
    Group::BundesArbeitsbereichWölflingsstufe,
    Group::BundesArbeitsbereichPfadfinderstufe,
    Group::BundesArbeitsbereichRangerRoverstufe,
    Group::BundesArbeitsbereichStufen,
    Group::BundesArbeitsbereichErwachsenenarbeit,
    Group::BundesArbeitsbereichAusbildung,
    Group::BundesArbeitsbereichInternationales,
    Group::BundesArbeitsbereichIntakt,
    Group::BundesArbeitsbereichOeffentlichkeitsarbeitMedien,
    Group::BundesArbeitsbereichPolitischeBildungPolitikUndGesellschaft,
    Group::BundesArbeitsbereichIT,
    Group::BundesArbeitsbereichFindungskommission,
    Group::BundesArbeitsbereichRainbow,
    Group::BundesArbeitsbereichInklusion,
    Group::BundesArbeitsbereichSonstiges,
    Group::GruppierungsspezifischesGremium,
    Group::HeimZeltplatzLiegenschaft,
    Group::Foerderverein

  default_children [
    Group::Bundesvorstand,
    Group::Ombudsrat
  ]

  ### ROLES

  class MVAdmin < ::Role
    self.permissions = [:layer_and_below_full, :admin, :impersonation]
  end

  class ErfassungFuehrungszeugnis < ::Role
    self.permissions = [:layer_and_below_read, :group_and_below_efz]
  end

  class Kassenpruefung < ::Role
    self.permissions = []
  end

  class Bundesmitarbeiter < ::Role
    self.permissions = []
  end

  roles MVAdmin,
    ErfassungFuehrungszeugnis,
    Kassenpruefung,
    Bundesmitarbeiter
end
