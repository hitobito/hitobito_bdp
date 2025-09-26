# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

require "spec_helper"

describe :event_participation do
  subject { page }

  let(:person) { people(:leader) }
  let(:event) { Fabricate(:event, application_opening_at: 5.days.ago, groups: [group]) }
  let(:group) { person.roles.first.group }

  before do
    sign_in(person)
  end

  it "creates an event participation" do
    visit group_event_path(group_id: group, id: event)

    click_link("Anmelden")

    find_all('.top .btn-group button[type="submit"]').first.click # "Weiter"

    fill_in("Bemerkungen", with: "Wichtige Bemerkungen zu meiner Teilnahme")

    expect do
      click_button("Anmelden")

      is_expected.to have_text(
        "Teilnahme von #{person.full_name} in #{event.name} wurde erfolgreich erstellt. " \
        "Bitte überprüfe die Kontaktdaten und passe diese gegebenenfalls an."
      )
      is_expected.to have_text("Wichtige Bemerkungen zu meiner Teilnahme")
    end.to change { Event::Participation.count }.by(1)

    participation = Event::Participation.find_by(event: event, participant: person)

    expect(participation).to be_present
  end
end
