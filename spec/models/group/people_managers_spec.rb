# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe Group::PeopleManagers do
  let!(:group) { Group::PeopleManagers.create!(parent: groups(:oberbayern_mauersegler)) }
  let(:kontakt_role_type) { Group::PeopleManagers::Kontakt.sti_name }

  it "assigns the Kontakt role as self registration role type" do
    expect(group.self_registration_role_type).to eq kontakt_role_type
  end

  it "restores the self registration role type when it is cleared" do
    group.update!(self_registration_role_type: nil)

    expect(group.reload.self_registration_role_type).to eq kontakt_role_type
  end

  describe "#self_registration_active?" do
    it "is true" do
      expect(group).to be_self_registration_active
    end

    it "is false when archived" do
      group.archived_at = Time.zone.now

      expect(group).not_to be_self_registration_active
    end

    it "is false in the decorator, so no self registration UI is shown" do
      expect(group.decorate).not_to be_self_registration_active
      expect(group.decorate.supports_self_registration?).to be false
    end
  end

  it "is included in the self_registration_active scope" do
    expect(Group.self_registration_active).to include(group)
  end
end
