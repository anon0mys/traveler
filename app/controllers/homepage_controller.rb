class HomepageController < ApplicationController
  def index
    @chart_data = Location.sum_of_countries
    @chart_data.unshift(['Country', 'Popularity'])
    render layout: false
  end
end
