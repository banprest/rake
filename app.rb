class App

  def call(env)
    @query = env["QUERY_STRING"]
    @path = env["REQUEST_PATH"]
    @user_format = Rack::Utils.parse_query(@query).values.join.split(',')

    if @path == '/time'
      time_format(@user_format)
    else
      response('Not found', 404)
    end
  end

  private

  def response(body, status)
    header = { 'Conent-Type' => 'text/plain' }
    Rack::Response.new(body, status, header).finish
  end

  def time_format(param)
    time_formatter = TimeFormatter.new(param)
    time_formatter.call

    if time_formatter.success?
      response(time_formatter.time, 200)
    else
      response(time_formatter.invalid, 400)
    end
  end
end
