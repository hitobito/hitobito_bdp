# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

class Group::KursFuerRangerRover < Group::Kurs
  ### ROLES

  class Kursleiter < ::Role
    self.permissions = [:group_read, :contact_data]
    self.sgbviii_required = true
  end

  class Kursteamer < ::Role
    self.permissions = [:group_read]
    self.sgbviii_required = true
  end

  class Referent < ::Role
    self.permissions = []
    self.sgbviii_required = true
  end

  class Mitarbeiter < ::Role
    self.permissions = []
    self.sgbviii_required = true
  end

  class KursKuechenteamer < ::Role
    self.permissions = []
    self.sgbviii_required = true
  end

  roles Kursleiter,
    Kursteamer,
    Referent,
    Mitarbeiter,
    KursKuechenteamer
end
