# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

module HitobitoBdp
  class Wagon < Rails::Engine
    include Wagons::Wagon

    # Set the required application version.
    app_requirement ">= 0"

    # Add a load path for this specific wagon
    config.autoload_paths += %W[
      #{config.root}/app/abilities
      #{config.root}/app/domain
      #{config.root}/app/jobs
    ]

    config.to_prepare do
      # extend application classes here
      Role.prepend Bdp::Role
      ServiceToken.prepend Bdp::ServiceToken

      RoleAbility.prepend Bdp::RoleAbility
      SelfRegistrationResource.prepend Bdp::SelfRegistrationResource

      Groups::SelfRegistrationController.prepend Bdp::Groups::SelfRegistrationController
      Groups::SelfInscriptionController.prepend Bdp::Groups::SelfInscriptionController

      Group::Gruppen.children Group::StammGruppeGilde

      Group::Stamm.used_attributes += [:efz_in_aufnahmeantrag]

      [Group::Bundesebene, Group::Landesverband, Group::Bezirk, Group::Stamm].each do |layer_group|
        layer_group.used_attributes += [:rechtsform]
      end

      Role::Permissions << :create_membership_roles

      [Group::Mitglieder::OrdentlicheMitgliedschaft,
        Group::Mitglieder::Foerdermitgliedschaft,
        Group::Mitglieder::Zweitmitgliedschaft].each do |role|
        role.membership_role = true
      end

      [Group::Bundesebene::MVAdmin,
        Group::Bundesgeschaeftsstelle::Bundesgeschaeftsfuehrung,
        Group::Bundesgeschaeftsstelle::MitgliederverwaltungBund].each do |role|
        role.permissions += [:create_membership_roles]
      end
    end

    initializer "bdp.add_settings" do |_app|
      Settings.add_source!(File.join(paths["config"].existent, "settings.yml"))
      Settings.reload!
    end

    initializer "bdp.add_inflections" do |_app|
      ActiveSupport::Inflector.inflections do |inflect|
        # inflect.irregular "census", "censuses"
      end
    end

    private

    def seed_fixtures
      fixtures = root.join("db", "seeds")
      ENV["NO_ENV"] ? [fixtures] : [fixtures, File.join(fixtures, Rails.env)] # rubocop:disable Rails/EnvironmentVariableAccess -- This is initialization
    end
  end
end
