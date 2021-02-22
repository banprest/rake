class TimeFormatter

  TIME = { year: "%Y", month: "%m", 
           day: "%d", hour: "%H", 
           minute: "%M", second: "%S"
         }

  def initialize(params)
    @user_params = params
    @access_format = TIME.keys.join(',').split(',')
    @valid_time = []
    @invalid_time = []
  end

  def call
    @user_params.each do |param|
      if success?
        @valid_time << TIME[param.to_sym]
      else
        @invalid_time = unknown_format
      end
    end
  end

  def time
    Time.now.strftime(@valid_time*"-")
  end

  def success?
    (@user_params - @access_format).empty?
  end

  def unknown_format
    @user_params - @access_format
  end

  def invalid
    "Unknown time format #{@invalid_time}"
  end
end
