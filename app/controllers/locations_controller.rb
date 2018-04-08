class LocationsController < ApplicationController
  def index
    @locations = Location.maps_loc_prep
    @center = query_params.as_json
  end

  def show
    @location = Location.find(params[:id])
    @posts = @location.posts
  end

  def query_params
    if params[:country]
      country = Country.find_by_code(params[:country])
      { lat: country.lat, lng: country.lng}
    else
      { lat: 39.742043, lng: -104.991531 }
    end
  end
end
