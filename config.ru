require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://127.0.0.1:6379', namespace: 'exq' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://127.0.0.1:6379', namespace: 'exq' }
end

require 'sidekiq/web'

# use Rack::Session::Cookie, secret: ENV['RACK_SESSION_COOKIE']
map '/' do
  run Sidekiq::Web
end
