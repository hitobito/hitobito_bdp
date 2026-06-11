# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

class AddCreateMembershipRolesToServiceTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :service_tokens, :create_membership_roles, :boolean, default: false, null: false
  end
end
