require 'rack'
require 'byebug'

class ExceptionMiddleware
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      app.call(env)
    rescue Exception => e
      body = ERB.new(File.read("./views/my_controller/exception.html.erb")).result(binding)
      [500, {'Content-Type' => 'text/html'}, [body]]
    end
  end
end
