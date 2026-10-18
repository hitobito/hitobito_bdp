# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

module Bdp::Export::Pdf::Document
  extend ActiveSupport::Concern

  def set_font
    super
    dir = HitobitoBdp::Wagon.instance.root.join("app", "assets", "fonts")
    pdf.font_families.update("einfachBdP" => {
      normal: dir.join("einfachBdP-Klassisch.ttf"),
      bold: dir.join("einfachBdP-Stark.ttf"),
      italic: dir.join("einfachBdP-Kursiv.ttf")
    })
    pdf.font "einfachBdP"
  end
end
