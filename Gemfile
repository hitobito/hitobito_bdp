load File.expand_path('../app_root.rb', __FILE__)

source 'https://rubygems.org'

# Declare your gem's dependencies in hitobito_bdp.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Load application Gemfile for all application dependencies.
eval File.read(File.expand_path('Gemfile', ENV['APP_ROOT']))

group :development, :test do
  # Explicitly define the path for dependencies on other wagons.
  gem 'hitobito_pfadi_de', path: "#{ENV["APP_ROOT"]}/../"
end
