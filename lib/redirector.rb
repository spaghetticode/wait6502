class Redirector
  def initialize(app)
    @app = app
  end
  
  def call(env)
    request = Rack::Request.new(env)
    if request.env['PATH_INFO'].include?('peripherals')
      location = request.env['PATH_INFO'].gsub(/peripherals/, 'old-computers')
      return [301, {'Location' => location}, []]
    end
    @app.call(env)
  end
end