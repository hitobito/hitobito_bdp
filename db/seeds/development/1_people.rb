# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.


require Rails.root.join("db", "seeds", "support", "person_seeder")

class BdpPersonSeeder < PersonSeeder

  def amount(role_type)
    case role_type.name.demodulize
    when "Woelfling", "Pfadfinder", "RangerRover", "Mitglied" then 3
    else 1
    end
  end

end

puzzlers = [
  "Carlo Beltrame",
  "Olivier Brian",
  "Oliver Dietschi",
  "Thomas Ellenberger",
  "Daniel Illi",
  "Niklas Jäggi",
  "Andreas Maierhofer",
  "Nils Rauch",
  "Matthias Viehweger",
  "Pascal Zumkehr",
]

devs = {
  "Sebastian Köngeter" => "sebastian.koengeter@pfadfinden.de",
  "Julius Störrle" => "julius.stoerrle@pfadfinden.de",
  "Eric Schümann" => "Eric.Schuemann@dpsg.de",
}
puzzlers.each do |puz|
  devs[puz] = "#{puz.split.last.downcase.gsub("ü", "ue").gsub("ä", "ae")}@puzzle.ch"
end

seeder = BdpPersonSeeder.new

seeder.seed_all_roles

root = Group.root
devs.each do |name, email|
  seeder.seed_developer(name, email, root, Group::Bundesebene::MVAdmin)
end
