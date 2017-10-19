class MiddlewareHealthcheck
  OK_RESPONSE = [ 200, { 'Content-Type'.freeze => 'text/plain'.freeze }, [ "ok".freeze ] ]

  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'.freeze] == '/healthcheck'.freeze
      OK_RESPONSE
    else
      @app.call(env)
    end
  end
end
