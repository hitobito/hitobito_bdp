# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

module Bdp::Export::Pdf::EfzAntrag
  extend ActiveSupport::Concern

  def generate
    set_default_font
    super
  end

  private

  def set_default_font
    dir = HitobitoBdp::Wagon.instance.root.join("app", "assets", "fonts")
    doc.config["font.map"] = (doc.config["font.map"] || {}).merge(
      "einfachBdP" => {
        none: dir.join("einfachBdP-Klassisch.ttf"),
        bold: dir.join("einfachBdP-Stark.ttf")
      }
    )
    doc.acro_form.set_default_appearance_string(font: "einfachBdP")
  end
end
