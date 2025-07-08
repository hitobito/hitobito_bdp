# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.


require Rails.root.join("db", "seeds", "support", "group_seeder")

seeder = GroupSeeder.new

root = Group::Bundesebene.first
srand(42)

if root.address.blank?
  root.update(seeder.group_attributes)
  root.default_children.each do |child_class|
    child_class.first.update(seeder.group_attributes)
  end
end

landesverbaende = Group::Landesverband.seed(:name, :parent_id,
  {name: "Bayern",
   street: "Severinstraße",
   housenumber: 5,
   zip_code: "81541",
   town: "München",
   country: "DE",
   email: "bayern@pfadfinden.de",
   parent_id: root.id},
  {name: "Schleswig-Holstein & Hamburg",
   short_name: "SH-HH",
   street: "Lohe",
   housenumber: 11,
   zip_code: "22941",
   town: "Bargteheide",
   country: "DE",
   email: "sh-hh@pfadfinden.de",
   parent_id: root.id},
  {name: "Baden-Württemberg",
    short_name: "BaWü",
    street: "Ludwigstraße",
    housenumber: 5,
    zip_code: "75045",
    town: "Walzbachtal",
    country: "DE",
    email: "bawue@pfadfinden.de",
    parent_id: root.id},
)

landesverbaende.each do |l|
  seeder.seed_social_accounts(l)
end

bezirke = Group::Bezirk.seed(:name, :parent_id,
  {name: "Franken Oberpfalz",
   short_name: "FOP",
   country: "DE",
   email: "bezirk.fop@bayern.pfadfinden.de",
   parent_id: landesverbaende[0].id
  }.merge(seeder.group_attributes)
)

bezirke.each do |l|
  seeder.seed_social_accounts(l)
end

staemme = Group::Stamm.seed(:name, :parent_id,
  {name: "Mauersegler",
   parent_id: bezirke[0].id
  }.merge(seeder.group_attributes),
  {name: "Duburg",
   parent_id: landesverbaende[1].id
  }.merge(seeder.group_attributes),
  {name: "Sachsenwald",
   parent_id: landesverbaende[1].id
  }.merge(seeder.group_attributes),
  {name: "Adler",
   parent_id: landesverbaende[2].id
  }.merge(seeder.group_attributes),
  {name: "Burg Karlsruhe",
   parent_id: landesverbaende[2].id
  }.merge(seeder.group_attributes),
  {name: "Silberreiher",
   parent_id: landesverbaende[2].id
  }.merge(seeder.group_attributes),
)

Group::Meute.seed(:name, :parent_id,
  {name: "Die Meute",
   parent_id: staemme[0].id})
Group::Meute.seed(:name, :parent_id,
  {name: "Schwarzer Panther",
   parent_id: staemme[1].id})
Group::Meute.seed(:name, :parent_id,
  {name: "Kängurus",
   parent_id: staemme[2].id})
Group::Meute.seed(:name, :parent_id,
  {name: "Geckos",
   parent_id: staemme[2].id})
Group::Meute.seed(:name, :parent_id,
  {name: "Mondvögel",
   parent_id: staemme[2].id})
Group::Meute.seed(:name, :parent_id,
  {name: "Wölflinge",
   parent_id: staemme[3].id})
Group::Meute.seed(:name, :parent_id,
  {name: "Werwölflinge",
   parent_id: staemme[4].id})
Group::Meute.seed(:name, :parent_id,
  {name: "Baghira",
   parent_id: staemme[5].id})

Group::Sippe.seed(:name, :parent_id,
  {name: "Die Pfadfinder-Stufe",
   parent_id: staemme[0].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Füchse",
   parent_id: staemme[1].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Schnabeltiere",
   parent_id: staemme[2].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Lemuren",
   parent_id: staemme[2].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Flughörnchen",
   parent_id: staemme[2].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Pfadfinder*innen",
   parent_id: staemme[3].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Mondphönixe",
   parent_id: staemme[4].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Sternkrieger",
   parent_id: staemme[4].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Beluga",
   parent_id: staemme[4].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Eiswölfe",
   parent_id: staemme[4].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Seegurke",
   parent_id: staemme[5].id})
Group::Sippe.seed(:name, :parent_id,
  {name: "Schneeeule",
   parent_id: staemme[5].id})

Group::Runde.seed(:name, :parent_id,
  {name: "Ranger & Rover",
   parent_id: staemme[0].id})
Group::Runde.seed(:name, :parent_id,
  {name: "Die Runde",
   parent_id: staemme[1].id})
Group::Runde.seed(:name, :parent_id,
  {name: "Die runde Runde",
   parent_id: staemme[3].id})
Group::Runde.seed(:name, :parent_id,
  {name: "Ranger & Rover",
   parent_id: staemme[4].id})
Group::Runde.seed(:name, :parent_id,
  {name: "Feuerfüchse",
   parent_id: staemme[5].id})
Group::Runde.seed(:name, :parent_id,
  {name: "Singerrunde der Passiven",
   parent_id: staemme[5].id})

Group.rebuild!
