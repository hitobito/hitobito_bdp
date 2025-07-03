# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Landesverband < ::Group
  self.layer = true

  children Group::Bezirk,
    Group::Stamm,
    Group::Landesvorstand,
    Group::Landesgeschaeftsstelle,
    Group::Landesversammlung,
    Group::Mitglieder,
    Group::Kontakte,
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
    Group::Landesvorstand
  ]

  ### ROLES

  class Landesmitgliederverwaltung < ::Role
    self.permissions = [:layer_and_below_full, :contact_data]
    self.two_factor_authentication_enforced = true
  end

  class ErfassungFuehrungszeugnis < ::Role
    self.permissions = [:layer_and_below_read, :group_and_below_efz]
    self.two_factor_authentication_enforced = true
  end

  class Kassenpruefung < ::Role
    self.permissions = []
  end

  class StammeskompassModeration < ::Role
    self.permissions = []
  end

  class Landesmitarbeiter < ::Role
    self.permissions = []
  end

  class JuleicaInhaber < ::Role
    self.permissions = []
  end

  class Materialwartung < ::Role
    self.permissions = []
  end

  class Bundesdelegiert < ::Role
    self.permissions = []
  end

  class BundesdelegiertErsatz < ::Role
    self.permissions = []
  end

  class BundeslagerUnterlagerleitung < ::Role
    self.permissions = []
  end

  class BundeslagerUnterlagerbereichsleitung < ::Role
    self.permissions = []
  end

  class BundeslagerMitarbeitUnterlager < ::Role
    self.permissions = []
  end

  class Landeswahlobmensch < ::Role
    self.permissions = []
  end

  class Zuschussbeauftragt < ::Role
    self.permissions = []
  end

  roles Landesmitgliederverwaltung,
    ErfassungFuehrungszeugnis,
    Kassenpruefung,
    StammeskompassModeration,
    Landesmitarbeiter,
    JuleicaInhaber,
    Materialwartung,
    Bundesdelegiert,
    BundesdelegiertErsatz,
    BundeslagerUnterlagerleitung,
    BundeslagerUnterlagerbereichsleitung,
    BundeslagerMitarbeitUnterlager,
    Landeswahlobmensch,
    Zuschussbeauftragt
end
