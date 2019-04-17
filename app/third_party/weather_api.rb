class WeatherApi
  BASE = 'http://api.openweathermap.org/data/2.5'.freeze
  KEY = '712h3jnf89sk0a87gbnma9'.freeze

  def temp(city)
    HTTParty.get(
      BASE + "/weather?q=#{city}&appid=" + KEY + '&units=metric'
    )
  end
end
