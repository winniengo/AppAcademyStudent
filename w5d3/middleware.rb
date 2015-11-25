require 'rack'

class ScreamingMiddleware
  attr_reader :app
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = app.call(env)
    body.map! { |chunk| chunk.to_s.upcase }
    [status, headers, body]
  end
end

class KittenMiddleware
  attr_reader :app
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.path.match(/^\/be_nice/)
      res = Rack::Response.new
      res.status = 302
      res['Location'] = 'https://i.ytimg.com/vi/6sta6Gkpgcw/maxresdefault.jpg'
      res.finish
    else
      app.call(env)
    end
  end
end

grumpy_app = Proc.new do |env|
  ['200', {}, ['I am very grumpy, >:(']]
end

app = Rack::Builder.new do
  use KittenMiddleware
  use ScreamingMiddleware
  run grumpy_app
end.to_app

Rack::Server.start(
  app: app,
  Port: 3000
)
