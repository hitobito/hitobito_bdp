# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

class Group::BezirkKursteams < ::Group
  children Group::Basiskurs,
    Group::KursFuerMeutenfuehrungen,
    Group::KursFuerSippenfuehrungen,
    Group::KursFuerGildenfuehrungen,
    Group::KursFuerRangerRover,
    Group::Grundkurs,
    Group::Querkurs,
    Group::LvSpezifischeAusbildung,
    Group::SonstigerKurs
end
