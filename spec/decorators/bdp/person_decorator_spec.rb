# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe PersonDecorator, :draper_with_helpers do
  subject(:decorator) { person.decorate }

  context "person with primary group" do
    let(:person) { people(:mauersegler_leiter) }

    its(:full_label) { should == "Mauersegler Leiter (Die Pfadfinder)" }
  end

  context "company" do
    let(:person) do
      people(:mauersegler_leiter).tap do |p|
        p.update!(company: true, company_name: "Coorp", first_name: "Fra", last_name: "Stuck")
      end
    end

    its(:full_label) { should == "Coorp (Fra Stuck)" }
  end
end
