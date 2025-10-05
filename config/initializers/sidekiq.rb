Sidekiq.configure_server do |config|
  config.redis = {
    url: "#{ENV.fetch('REDIS_URL') { 'redis://localhost:6379/' }}10",
    password: ENV.fetch('REDIS_PASSWORD') { '12345_abcd' }
  }
  schedule_file = 'config/schedule.yml'
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file)
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "#{ENV.fetch('REDIS_URL') { 'redis://localhost:6379/' }}10",
    password: ENV.fetch('REDIS_PASSWORD') { '12345_abcd' }
  }
end

require 'sidekiq/web'
Sidekiq::Web.set :sessions, false
