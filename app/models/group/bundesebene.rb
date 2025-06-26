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
    Group::Bundesversammlung,
    Group::Projekt,
    Group::Kontakte,
    Group::Mitglieder,
    Group::ArbeitsbereichWoelflingsstufe,
    Group::ArbeitsbereichPfadfinderstufe,
    Group::ArbeitsbereichRangerRoverstufe,
    Group::ArbeitsbereichStufen,
    Group::ArbeitsbereichErwachsenenarbeit,
    Group::ArbeitsbereichAusbildung,
    Group::ArbeitsbereichInternationales,
    Group::ArbeitsbereichIntakt,
    Group::ArbeitsbereichOeffentlichkeitsarbeitMedien,
    Group::ArbeitsbereichPolitischeBildungPolitikUndGesellschaft,
    Group::ArbeitsbereichIt,
    Group::ArbeitsbereichFindungskommission,
    Group::ArbeitsbereichRainbow,
    Group::ArbeitsbereichInklusion,
    Group::ArbeitsbereichSonstiges,
    Group::GruppierungsspezifischesGremium,
    Group::HeimZeltplatzLiegenschaft,
    Group::Foerderverein

  self.default_children = [
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
