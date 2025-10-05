require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WebCavallaro
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Allowed hosts
    config.hosts << 'dev.grupocavallaro.com'
    config.hosts << 'www.grupocavallaro.com'
    config.hosts << 'www.cavallaro.com.py'
    config.hosts << 'cavallaro.com.py'
    config.hosts << '127.0.0.1'
    config.hosts << '192.168.10.118'

    config.i18n.default_locale = :es

    config.active_job.queue_adapter = :sidekiq

    config.action_mailer.default_url_options = { host: 'https://www.cavallaro.com.py/' }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.cavallaro.com.py',
      port: 587,
      user_name: 'no-reply@cavallaro.com.py',
      password: 'Cavainfo.nr',
      authentication: 'login',
      enable_starttls_auto: true
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
