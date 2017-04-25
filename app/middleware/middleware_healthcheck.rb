class MiddlewareHealthcheck
  RESPONSE_STR = "It's alive!"
  OK_RESPONSE = [ 200, { 'Content-Type'.freeze => 'application/json'.freeze }, [ RESPONSE_STR.freeze ] ]

  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'.freeze] == '/healthcheck'.freeze
      return OK_RESPONSE
    else
      @app.call(env)
    end
  end
end
