# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rest-client'

response = RestClient.get('http://dataservice.accuweather.com/locations/v1/topcities/50', { params: { apikey: 'YjQVRmzwBmzhmzi6qi3xOQ20em8to7LJ' }})
location_hashes = JSON.parse(response)
location_hashes.each do |location_hash|
  Location.create(name: location_hash['LocalizedName'], key: location_hash['Key'])
end
