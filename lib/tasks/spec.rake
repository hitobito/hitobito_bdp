# frozen_string_literal: true

#  Copyright (c) 2012-2025, Bund der Pfadfinderinnen und Pfadfinder e.V.. This file is part of
#  hitobito_bdp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_bdp.


if Rake::Task.task_defined?("spec:features")
  # we DO have feature specs in this wagon.
  Rake::Task["spec:features"].actions.clear
  namespace :spec do
    RSpec::Core::RakeTask.new(:features) do |t|
      t.pattern = "./spec/features/**/*_spec.rb"
      t.rspec_opts = "--tag type:feature"
    end

    RSpec::Core::RakeTask.new(:without_features) do |t|
      t.pattern = "./spec/**/*_spec.rb"
      t.rspec_opts = "--tag ~type:feature"
    end

    task all: ["spec:features", "spec:without_features"]
  end

else
  # we do NOT have feature specs in this wagon.
  namespace :spec do
    task all: "spec"
    task without_features: "spec"
  end
end
