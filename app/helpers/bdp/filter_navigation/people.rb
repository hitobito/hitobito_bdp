# frozen_string_literal: true

#  Copyright (c) 2012-2026, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

module Bdp::FilterNavigation::People
  GRUPPENLEITUNG_ROLES = [
    Group::StammGruppeWoelflinge::Leitung,
    Group::StammGruppeWoelflinge::Hilfsleitung,
    Group::StammGruppePfadfinder::Leitung,
    Group::StammGruppePfadfinder::Hilfsleitung,
    Group::StammGruppeRover::Leitung,
    Group::StammGruppeRover::Hilfsleitung,
    Group::StammGruppeGilde::Leitung,
    Group::StammGruppeGilde::Hilfsleitung
  ].freeze

  STAMMESFUEHRUNG_ROLES = [
    Group::Stamm::Stammesfuehrung,
    Group::Stamm::StammesfuehrungStv,
    Group::Stamm::Stammesschatzmeister,
    Group::Stamm::StammesschatzmeisterStv
  ].freeze

  FUNKTIONSTRAEGER_ROLES = (
    Group::Stamm.role_types +
      [Group::GruppierungsspezifischesGremium::Leitung] +
      GRUPPENLEITUNG_ROLES
  ).freeze

  LANDESVORSTAND_ROLES = [
    Group::Landesvorstand::Landesvorsitz,
    Group::Landesvorstand::LandesvorsitzStv,
    Group::Landesvorstand::Landesschatzmeister,
    Group::Landesvorstand::LandesschatzmeisterStv
  ].freeze

  BUNDESVORSTAND_ROLES = [
    Group::Bundesvorstand::Bundesvorsitz,
    Group::Bundesvorstand::BundesvorsitzStv,
    Group::Bundesvorstand::Bundesschatzmeister,
    Group::Bundesvorstand::BundesschatzmeisterStv
  ].freeze

  PROJEKTE_ROLES = [
    Group::Projekt::Lagerleitung,
    Group::Projekt::LagerleitungStv,
    Group::Bereich::Bereichsleitung
  ].freeze

  ARBEITSBEREICHE_CONTAINER_TYPES = [
    Group::BundArbeitsbereiche,
    Group::LandArbeitsbereiche,
    Group::BezirkArbeitsbereiche,
    Group::StammArbeitsbereiche
  ].freeze

  INTAKT_TYPES = [
    Group::BundIntakt,
    Group::LandIntakt,
    Group::BezirkIntakt,
    Group::StammIntakt
  ].freeze

  KURSTEAMS_CONTAINER_TYPES = [
    Group::BundKursteams,
    Group::LandKursteams,
    Group::BezirkKursteams
  ].freeze

  class << self
    DEFAULT_FILTER_BUILDERS = {
      Group::Stamm => :funktionstraeger_default_filter,
      Group::Bundesebene => :bundesleitung_default_filter,
      Group::Landesverband => :landesleitung_default_filter,
      Group::Projekte => :projekte_default_filter,
      Group::Gruppen => :gruppenleitungen_default_filter,
      Group::StammGruppeGilde => :gesamte_gilde_default_filter
    }.freeze

    def default_filter(group_class)
      builder = DEFAULT_FILTER_BUILDERS[group_class]
      return send(builder) if builder

      if ARBEITSBEREICHE_CONTAINER_TYPES.include?(group_class)
        arbeitsbereiche_default_filter(group_class)
      elsif INTAKT_TYPES.include?(group_class)
        intakt_default_filter(group_class)
      elsif KURSTEAMS_CONTAINER_TYPES.include?(group_class)
        kursteams_default_filter(group_class)
      end
    end

    def funktionstraeger_default_filter
      [:funktionstraeger, FUNKTIONSTRAEGER_ROLES, "layer"]
    end

    def bundesleitung_default_filter
      [:bundesleitung, bundesleitung_roles, "layer"]
    end

    def landesleitung_default_filter
      [:landesleitung, landesleitung_roles, "layer"]
    end

    def projekte_default_filter
      [:projekte, PROJEKTE_ROLES, "layer"]
    end

    def gruppenleitungen_default_filter
      [:alle_gruppenleitungen, GRUPPENLEITUNG_ROLES, "deep"]
    end

    def gesamte_gilde_default_filter
      [:gesamte_gilde, sub_groups_role_types(Group::StammGruppeGilde), "deep"]
    end

    def arbeitsbereiche_default_filter(group_class)
      [:arbeitsbereiche, role_types_named(group_class, "Beauftragt", "AKLeitung"), "layer"]
    end

    def intakt_default_filter(group_class)
      [:alle_intakt_bereiche, sub_groups_role_types(group_class), "deep"]
    end

    def kursteams_default_filter(group_class)
      [:kursteams, role_types_named(group_class, "Kursleiter", "Kursteamer"), "layer"]
    end

    def bundesleitung_roles
      BUNDESVORSTAND_ROLES + role_types_named(Group::BundArbeitsbereiche, "Beauftragt")
    end

    def landesleitung_roles
      LANDESVORSTAND_ROLES + role_types_named(Group::LandArbeitsbereiche, "Beauftragt")
    end

    def role_types_named(start_type, *names)
      collect_group_types([start_type], start_type.possible_children)
        .flat_map(&:role_types)
        .select { |role_type| names.include?(role_type.name.demodulize) }
    end

    # Same member-role selection as core's own FilterNavigation::People#sub_groups_role_types,
    # but computed from a group class alone so it can be reused outside an instance.
    def sub_groups_role_types(group_class)
      collect_group_types([group_class], group_class.possible_children)
        .flat_map(&:role_types)
        .uniq
        .select(&:member?)
    end

    def collect_group_types(all, types)
      types.each do |type|
        unless all.include?(type) || type.layer?
          all << type
          collect_group_types(all, type.possible_children)
        end
      end
      all
    end
  end

  def initialize(*args)
    super
    add_bdp_main_items
  end

  private

  def init_kind_filter_names
    super
    @kind_filter_names[:member].sub!(member_kind_name, translate(:gruppenmitglieder))
  end

  def init_labels
    key, = Bdp::FilterNavigation::People.default_filter(group.klass)
    if key && name == translate(key)
      @active_label = name
    else
      super
    end
  end

  def init_dropdown_links
    super
    add_bdp_dropdown_links
  end

  def add_bdp_main_items
    key, role_types, range = Bdp::FilterNavigation::People.default_filter(group.klass)
    return unless key

    name = translate(key)
    item(name, fixed_types_path(name, role_types, range: range))
  end

  def add_bdp_dropdown_links
    klass = group.klass
    if klass == Group::Stamm
      add_stamm_dropdown_links
    elsif [Group::Landesverband, Group::Bezirk].include?(klass)
      add_stammesfuehrungen_dropdown_link
    elsif klass == Group::Mitglieder
      add_mitglieder_dropdown_links
    end
    add_historic_filter_link(member_kind_name, group.role_types.select(&:member?))
  end

  def add_stamm_dropdown_links
    name = translate(:stammesfuehrung)
    dropdown.add_item(name, fixed_types_path(name, STAMMESFUEHRUNG_ROLES, range: "layer"))
    add_historic_filter_link(name, STAMMESFUEHRUNG_ROLES, range: "layer")
  end

  def add_stammesfuehrungen_dropdown_link
    name = translate(:stammesfuehrungen)
    dropdown.add_item(name, fixed_types_path(name, STAMMESFUEHRUNG_ROLES, range: "deep"))
  end

  def add_mitglieder_dropdown_links
    name = translate(:ohne_foerdermitgliedschaften)
    dropdown.add_item(name, fixed_types_path(name, [
      Group::Mitglieder::OrdentlicheMitgliedschaft,
      Group::Mitglieder::Zweitmitgliedschaft
    ]))
    name = translate(:nur_foerdermitgliedschaften)
    dropdown.add_item(name, fixed_types_path(name, [Group::Mitglieder::Foerdermitgliedschaft]))
  end

  def member_kind_name
    I18n.t("activerecord.attributes.role.class.kind.member.other")
  end

  def add_historic_filter_link(name, role_types, options = {})
    return if role_types.blank?

    type_ids = role_types.collect(&:type_id).join(Person::Filter::Base::ID_URL_SEPARATOR)
    historic_name = "#{name} #{translate(:auch_ehemalige)}"
    dropdown.add_item(historic_name,
      path(options.merge(name: historic_name,
        filters: {role: {
          role_type_ids: type_ids,
          kind: "active",
          include_archived: true
        }})))
  end
end
