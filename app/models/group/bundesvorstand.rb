# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

class Group::Bundesvorstand < ::Group
  self.static_name = true

  ### ROLES

  class Bundesvorsitz < ::Role
    self.permissions = [:layer_and_below_full, :contact_data]
    self.two_factor_authentication_enforced = true
  end

  class BundesvorsitzStv < ::Role
    self.permissions = [:layer_and_below_full, :contact_data]
    self.two_factor_authentication_enforced = true
  end

  class Bundesschatzmeister < ::Role
    self.permissions = [:layer_and_below_full, :contact_data, :finance]
    self.two_factor_authentication_enforced = true
  end

  class BundesschatzmeisterStv < ::Role
    self.permissions = [:layer_and_below_full, :contact_data, :finance]
    self.two_factor_authentication_enforced = true
  end

  class EmpfaengerAufnahmeantragUeber18 < ::Role
    self.permissions = []
  end

  roles Bundesvorsitz,
    BundesvorsitzStv,
    Bundesschatzmeister,
    BundesschatzmeisterStv,
    EmpfaengerAufnahmeantragUeber18
end
