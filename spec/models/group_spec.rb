# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

require "spec_helper"

describe Group do
  include_examples "group types"

  describe "validate_self_registration_role_type" do
    let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

    context "with membership role as self_registration_role_type" do
      before do
        group.self_registration_role_type = "Group::Mitglieder::OrdentlicheMitgliedschaft"
      end

      it "is valid" do
        expect(group).to be_valid
      end
    end
  end
end
