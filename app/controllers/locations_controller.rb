class LocationsController < ApplicationController
  def index
    @locations = Location.maps_loc_prep
    @lat = 39.742043
    @long = -104.991531
  end
end
