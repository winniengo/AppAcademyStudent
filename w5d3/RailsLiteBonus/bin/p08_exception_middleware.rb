# TODO
# render 1. the stack trace 2. preview of the source code where the exception
# was raised 3. the exception message

require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative 'dog'
require_relative '../lib/exception_middleware'

router = Router.new
router.draw do
  get Regexp.new("^/dogs$"), DogsController, :index
  get Regexp.new("^/dogs/new$"), DogsController, :new
  get Regexp.new("^/dogs/(?<id>\\d+)$"), DogsController, :show
  post Regexp.new("^/dogs$"), DogsController, :create
end

base = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ExceptionMiddleware
  run base
end.to_app

Rack::Server.start(
  app: app,
  Port: 3000
)
