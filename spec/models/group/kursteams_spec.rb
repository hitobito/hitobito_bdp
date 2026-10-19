# frozen_string_literal: true

#  Copyright (c) 2026, Bund der Pfadfinderinnen und Pfadfinder e.V. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp

require "spec_helper"

describe "Kursteams group structure" do
  kurs_labels = {
    Group::Basiskurs => "Basiskurs",
    Group::KursFuerMeutenfuehrungen => "Kurs für Meutenführungen",
    Group::KursFuerSippenfuehrungen => "Kurs für Sippenführungen",
    Group::KursFuerGildenfuehrungen => "Kurs für Gildenführungen",
    Group::KursFuerRangerRover => "Kurs für Ranger/Rover",
    Group::Grundkurs => "Grundkurs",
    Group::Gilwellkurs => "Gilwellkurs",
    Group::Querkurs => "Querkurs",
    Group::IbSeminar => "IB-Seminar",
    Group::LvSpezifischeAusbildung => "LV-spezifische Ausbildung",
    Group::SonstigerKurs => "Sonstiger Kurs"
  }.freeze

  kurs_roles = {
    "Kursleiter" => {permissions: [:group_read, :contact_data], sgbviii_required: true,
                     label: "Kursleiter*in"},
    "Kursteamer" => {permissions: [:group_read], sgbviii_required: true,
                     label: "Kursteamer*in"},
    "Referent" => {permissions: [], sgbviii_required: true, label: "Referent*in"},
    "Mitarbeiter" => {permissions: [], sgbviii_required: true, label: "Mitarbeiter*in"},
    "KursKuechenteamer" => {permissions: [], sgbviii_required: true,
                            label: "Kurs-Küchenteamer*in"}
  }.freeze

  it "Group::Kurs defines no roles of its own and is never a possible child" do
    expect(Group::Kurs.role_types).to be_empty
    expect(Group.all_types.flat_map(&:possible_children)).not_to include(Group::Kurs)
  end

  kurs_labels.each do |kurs_type, label|
    it "#{kurs_type} subclasses the global Kurs base and is labeled #{label}" do
      expect(kurs_type.ancestors).to include(Group::Kurs)
      expect(kurs_type.model_name.human).to eq(label)
    end

    it "#{kurs_type} defines the Kursteams roles with their permissions and labels" do
      aggregate_failures do
        kurs_roles.each do |role_name, attrs|
          role_class = kurs_type.const_get(role_name)
          expect(role_class.permissions).to eq(attrs[:permissions])
          expect(role_class.sgbviii_required).to eq(attrs[:sgbviii_required])
          expect(role_class.model_name.human).to eq(attrs[:label])
        end
      end
    end
  end

  {bund: Group::Bundesebene, land: Group::Landesverband, bezirk: Group::Bezirk}.each do
    |layer, layer_type|
    kursteams_type = "Group::#{layer.to_s.camelize}Kursteams".constantize

    it "#{layer_type} has Kursteams as a possible and default child" do
      expect(layer_type.possible_children).to include(kursteams_type)
      expect(layer_type.default_children).to include(kursteams_type)
    end

    it "#{kursteams_type} defines no roles of its own, is labeled Kursteams and only " \
       "offers global courses as children" do
      expect(kursteams_type.role_types).to be_empty
      expect(kursteams_type.model_name.human).to eq("Kursteams")
      expect(kursteams_type.possible_children).to be_present
      expect(kursteams_type.possible_children - kurs_labels.keys).to be_empty
    end
  end
end
