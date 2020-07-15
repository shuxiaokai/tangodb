require_relative 'boot'

# See https://github.com/rails/rails/blob/v6.0.2.1/railties/lib/rails/all.rb for the list
# of what is being included here
require "rails"

# This list is here as documentation only - it's not used
omitted = %w(
  action_cable/engine
  action_mailbox/engine
  action_text/engine
)

# Only the frameworks in Rails that do not pollute our routes
%w(
  active_record/railtie
  active_storage/engine
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TangoLibrary
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.assets.paths << Rails.root.join("app", "assets", "img")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
 
end
