load './app/base.rb'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins "*"
    resource "*",
      headers: 'Content-Type, Authorization',
      methods: [:get, :post, :options, :head],
      max_age: 3600 # 1 hour
  end
end

run App::Base.freeze.app