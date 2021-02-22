class TimeFormatter

  TIME = { year: "%Y", month: "%m", 
           day: "%d", hour: "%H", 
           minute: "%M", second: "%S"
         }

  def initialize(params)
    @user_params = params
    @access_format = %w(year month day hour minute second)
    @valid_time = []
  end

  def call
    @user_params.each do |param|
      @valid_time << TIME[param.to_sym]
    end
  end

  def time
    Time.now.strftime(@valid_time*"-")
  end

  def access?
    (@user_params - @access_format).empty?
  end

  def unknown_format
    @user_params - @access_format
  end

  def invalid
    "Unknown time format #{unknown_format}"
  end
end
