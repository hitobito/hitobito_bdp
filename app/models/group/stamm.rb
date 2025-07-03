# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Stamm < ::Group
  self.layer = true

  children Group::Mitglieder,
    Group::StammesArbeitsbereichWölflingsstufe,
    Group::StammesArbeitsbereichPfadfinderstufe,
    Group::StammesArbeitsbereichRangerRoverstufe,
    Group::StammesArbeitsbereichStufen,
    Group::StammesArbeitsbereichErwachsenenarbeit,
    Group::StammesArbeitsbereichAusbildung,
    Group::StammesArbeitsbereichInternationales,
    Group::StammesArbeitsbereichIntakt,
    Group::StammesArbeitsbereichOeffentlichkeitsarbeitMedien,
    Group::StammesArbeitsbereichPolitischeBildungPolitikUndGesellschaft,
    Group::StammesArbeitsbereichIT,
    Group::StammesArbeitsbereichFindungskommission,
    Group::StammesArbeitsbereichRainbow,
    Group::StammesArbeitsbereichInklusion,
    Group::StammesArbeitsbereichSonstiges,
    Group::HeimZeltplatzLiegenschaft,
    Group::GruppierungsspezifischesGremium,
    Group::Foerderverein,
    Group::Meute,
    Group::Gilde,
    Group::Sippe,
    Group::Runde

  ### ROLES

  class Stammesfuehrung < ::Role
    self.permissions = [:group_read]
  end

  class StammesfuehrungStv < ::Role
    self.permissions = [:group_read]
  end

  class Stammesschatzmeister < ::Role
    self.permissions = [:group_read]
  end

  class StammesschatzmeisterStv < ::Role
    self.permissions = [:group_read]
  end

  class EmpfaengerAufnahmeantragStammesfuehrung < ::Role
    self.permissions = []
  end

  class Stammesmitgliederverwaltung < ::Role
    self.permissions = [:layer_and_below_full]
    self.two_factor_authentication_enforced = true
  end

  class ErfassungFuehrungszeugnis < ::Role
    self.permissions = [:layer_and_below_read, :group_and_below_efz]
    self.two_factor_authentication_enforced = true
  end

  class Kassenpruefung < ::Role
    self.permissions = []
  end

  class Zuschussbeauftragt < ::Role
    self.permissions = []
  end

  class AnsprechpersonBundeslager < ::Role
    self.permissions = []
  end

  class Stammeskaemmerer < ::Role
    self.permissions = []
  end

  class Materialwartung < ::Role
    self.permissions = []
  end

  class AnsprechpersonHeimvermietung < ::Role
    self.permissions = []
  end

  class Heimwartung < ::Role
    self.permissions = []
  end

  class JuleicaInhaber < ::Role
    self.permissions = []
  end

  class Stammesbeauftragt < ::Role
    self.permissions = []
  end

  class Landesdelegiert < ::Role
    self.permissions = []
  end

  class LandesdelegiertErsatz < ::Role
    self.permissions = []
  end

  class Bezirksdelegiert < ::Role
    self.permissions = []
  end

  class Stammesgeschaeftsstelle < ::Role
    self.permissions = []
  end

  roles Stammesfuehrung,
    StammesfuehrungStv,
    Stammesschatzmeister,
    StammesschatzmeisterStv,
    EmpfaengerAufnahmeantragStammesfuehrung,
    Stammesmitgliederverwaltung,
    ErfassungFuehrungszeugnis,
    Kassenpruefung,
    Zuschussbeauftragt,
    AnsprechpersonBundeslager,
    Stammeskaemmerer,
    Materialwartung,
    AnsprechpersonHeimvermietung,
    Heimwartung,
    JuleicaInhaber,
    Stammesbeauftragt,
    Landesdelegiert,
    LandesdelegiertErsatz,
    Bezirksdelegiert,
    Stammesgeschaeftsstelle
end
