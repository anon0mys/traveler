class LocationsController < ApplicationController
  def index
    @locations = Location.maps_loc_prep
    @lat = 39.742043
    @lng = -104.991531
  end

  def show
    @location = Location.find(params[:id])
    @posts = @location.posts
  end
end
