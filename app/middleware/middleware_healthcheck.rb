class MiddlewareHealthcheck
  OK_RESPONSE = [ 200, { 'Content-Type' => 'application/json' }, [ "It's alive!" ] ]

  def initialize(app)
    @app = app
  end

  def call(env)
    return OK_RESPONSE if env['PATH_INFO'] == '/healthcheck'
    dup._call(env)
  end

  def _call(env)
    status, headers, body = @app.call(env)
    [status, headers, body]
  ensure
    body.close if body && body.respond_to?(:close) && $!
  end
end
