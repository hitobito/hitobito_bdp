# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Landesvorstand < ::Group
  self.static_name = true

  ### ROLES

  class Landesvorsitz < ::Role
    self.permissions = [:layer_and_below_read, :contact_data]
    self.two_factor_authentication_enforced = true
  end

  class LandesvorsitzStv < ::Role
    self.permissions = [:layer_and_below_read, :contact_data]
    self.two_factor_authentication_enforced = true
  end

  class Landesschatzmeister < ::Role
    self.permissions = [:layer_and_below_read, :contact_data, :finance]
    self.two_factor_authentication_enforced = true
  end

  class LandesschatzmeisterStv < ::Role
    self.permissions = [:layer_and_below_read, :contact_data, :finance]
    self.two_factor_authentication_enforced = true
  end

  class EmpfaengerAufnahmeantragLVUnter18 < ::Role
    self.permissions = []
  end

  class EmpfaengerAufnahmeantragLVUeber18 < ::Role
    self.permissions = []
  end

  roles Landesvorsitz,
    LandesvorsitzStv,
    Landesschatzmeister,
    LandesschatzmeisterStv,
    EmpfaengerAufnahmeantragLVUnter18,
    EmpfaengerAufnahmeantragLVUeber18
end
