# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Landesgeschaeftsstelle < ::Group
  ### ROLES

  class Landesgeschaeftsfuehrung < ::Role
    self.permissions = [:layer_and_below_full, :contact_data, :finance]
  end

  class HauptamtlichSachbearbeitung < ::Role
    self.permissions = [:layer_and_below_read, :contact_data]
  end

  class HauptamtlichReferent < ::Role
    self.permissions = [:layer_and_below_read, :contact_data]
  end

  class Hauptamtlich < ::Role
    self.permissions = [:contact_data]
  end

  roles Landesgeschaeftsfuehrung,
    HauptamtlichSachbearbeitung,
    HauptamtlichReferent,
    Hauptamtlich
end
