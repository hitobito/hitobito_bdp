# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.


require Rails.root.join("db", "seeds", "support", "group_seeder")

seeder = GroupSeeder.new

root = Group.roots.first
srand(42)

if root.address.blank?
  root.update(seeder.group_attributes)
  root.default_children.each do |child_class|
    child_class.first.update(seeder.group_attributes)
  end
end

# TODO: define more groups

Group.rebuild!
