class App

  def call(env)
    @query = env["QUERY_STRING"]
    @path = env["REQUEST_PATH"]
    @user_format = Rack::Utils.parse_query(@query).values.join.split(',')
    @access_format = %w(year month day hour minute second)

    [status, headers, body]
  end

  private

  def status
    if @path == '/time' && access?
      200
    elsif @path == '/time'
      400
    else
      404
    end
  end

  def headers
    { 'Conent-Type' => 'text/plain' }
  end

  def body
    if @path == '/time' && access?
      [convert_user_format]
    elsif @path == '/time'
      ["Unknown time format #{unknown_format}"]
    else
      ['Not found']
    end
  end

  def access?
    (@user_format - @access_format).empty?
  end

  def unknown_format
    @user_format - @access_format
  end

  def convert_user_format
    @user_format.map! { |t| case t
                              when 'year'
                                t = Time.now.year
                              when 'month'
                                t = Time.now.month
                              when 'day' 
                                t = Time.now.day 
                              when 'hour'
                                t = Time.now.hour
                              when 'minute'
                                t = Time.now.min 
                              when 'second'
                                t = Time.now.sec 
                            end 
                          }
    @user_format.join('-')
  end
end
