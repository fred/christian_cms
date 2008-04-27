class Weather < ActiveRecord::Base
  
  def yeahoo_weather
    client = YahooWeather::Client.new
    bkk = "THXX0002"
    response = client.lookup_location(bkk, 'c')
    @today_weather = response.forecasts[0]
    @tomorrow_weather = response.forecasts[1]
  end  
  
end
