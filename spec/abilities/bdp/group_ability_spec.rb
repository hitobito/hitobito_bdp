# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe GroupAbility do
  subject(:ability) { Ability.new(people(:mauersegler_mitglied)) }

  context "using the self registration API with a session cookie" do
    let(:stamm) { groups(:oberbayern_mauersegler) }

    it "may not register_people, even in a self registration active Group::PeopleManagers" do
      people_managers_group = Group::PeopleManagers.create!(parent: stamm)

      is_expected.not_to be_able_to(:register_people, people_managers_group)
    end

    it "may not register_people in a self registration active group of another type" do
      mitglied_role = Group::Mitglieder::OrdentlicheMitgliedschaft.sti_name
      group = groups(:oberbayern_mauersegler_mitglieder)
      group.update!(self_registration_role_type: mitglied_role)

      is_expected.not_to be_able_to(:register_people, group)
    end
  end
end
