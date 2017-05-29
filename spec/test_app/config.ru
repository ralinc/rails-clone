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

run App.new
