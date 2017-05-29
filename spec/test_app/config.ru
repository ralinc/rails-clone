# This file is used by Rack-based servers to start the application.

# require_relative 'config/environment'

# run Rails.application

class App
  def call(env)
    [
      200,
      {'Content-Type' => 'text/html'},
      ['<h1>Hello World!</h1>', '<p>My first Rack application.</p>'],
    ]
  end
end

class Logger
  def initialize(app)
    @app = app
  end

  def call(env)
    method = env['REQUEST_METHOD']
    path = env['PATH_INFO']

    puts "#{method} #{path}"

    @app.call env
  end
end

use Logger
run App.new
