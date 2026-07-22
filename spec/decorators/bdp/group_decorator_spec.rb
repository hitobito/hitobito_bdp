# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe GroupDecorator, :draper_with_helpers do
  let(:group) { groups(:oberbayern_mauersegler_mitglieder) }

  subject(:decorator) { group.decorate }

  it "supports_self_registration? always returns false" do
    # In core, self registration is supported if allowed_roles_for_self_registration is present.
    # In bdp, self registration is always disabled.
    expect(decorator.allowed_roles_for_self_registration).to be_present
    expect(decorator.supports_self_registration?).to be false
  end
end
