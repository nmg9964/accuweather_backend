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

  def find_forecasts
    @location = Location.find_by(key: params[:key])
    forecasts = []
    response = RestClient.get("http://dataservice.accuweather.com/forecasts/v1/daily/5day/#{@location.key}", { params: { apikey: Rails.application.credentials.dig(:api_key) }})
    weather_data = JSON.parse(response)
    forecasts.push(weather_data['DailyForecasts'])
    three_day_forecast = forecasts[0][0..2]
    render json: three_day_forecast
  end

end
