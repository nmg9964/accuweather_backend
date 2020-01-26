require 'rest-client'

class LocationsController < ApplicationController

  def index
    @locations = Location.all 
    render json: @locations
  end

  def show
    @location = Location.find(params[:id])
    render json: @location
  end

  def display_forecasts
    @location = Location.find_by(key: params[:key])
    forecasts = []
    forecasts.push(find_forecasts(@location))
    three_day_forecast = forecasts[0][0..2]
    render json: three_day_forecast
  end

  private

  def find_forecasts(location)
    response = RestClient.get("http://dataservice.accuweather.com/forecasts/v1/daily/5day/#{location.key}", {params: { apikey: 'YjQVRmzwBmzhmzi6qi3xOQ20em8to7LJ' }})
    weather_data = JSON.parse(response)
    weather_data['DailyForecasts']
  end

end
