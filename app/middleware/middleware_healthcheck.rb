class MiddlewareHealthcheck
  RESPONSE_STR = "It's alive!"
  # RESPONSE_STR = ENV.to_json
  OK_RESPONSE = [ 200, { 'Content-Type' => 'application/json' }, [ RESPONSE_STR ] ]

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
