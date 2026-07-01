# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.

require "spec_helper"

describe "Graphiti schema" do
  # Skip the schema specs for now as the SelfRegistrationResource is not changing
  # the schema and we don't want the burden of maintaining the schema.json
  # Should other resource files be added in the future, the check fails and the
  # schema check is executed.
  skip_schema_specs = HitobitoBdp::Wagon.root.glob("app/resources/**/*.rb").reject do |f|
    f.to_s.match?("self_registration_resource.rb")
  end.blank?

  unless skip_schema_specs
    it_behaves_like "graphiti schema file is up to date"
  end
end
