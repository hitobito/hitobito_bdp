# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

ENGINE_PATH = File.expand_path(__dir__)
load File.expand_path("app_root.rb", __dir__)

load "wagons/wagon_tasks.rake"

load "rspec/rails/tasks/rspec.rake"

require "ci/reporter/rake/rspec" unless Rails.env.production?

HitobitoBdp::Wagon.load_tasks

task "test:prepare" => "db:test:prepare"
