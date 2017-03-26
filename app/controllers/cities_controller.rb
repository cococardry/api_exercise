class CitiesController < ApplicationController
  def index
    @cities=City.all
    # binding.pry
  end

  def update_temp
    cc=City.find(params[:id])
    response = RestClient.get "http://v.juhe.cn/weather/index",
                                  :params => { :cityname => cc.juhe_id, :key => JUHE_CONFIG["api_key"] }
        data = JSON.parse(response.body)

        cc.update( :current_temp => data["result"]["sk"]["temp"] )

        redirect_to cities_path
  end
  def update_wind
    cc=City.find(params[:id])
    response = RestClient.get "http://v.juhe.cn/weather/index",
                                  :params => { :cityname => cc.juhe_id, :key => JUHE_CONFIG["api_key"] }
        data = JSON.parse(response.body)

        cc.update( :wind_direction => data["result"]["sk"]["wind_direction"],
                   :wind_strength => data["result"]["sk"]["wind_strength"])

        redirect_to cities_path
  end
end
