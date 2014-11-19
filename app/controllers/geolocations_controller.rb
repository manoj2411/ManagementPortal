class GeolocationsController < ApplicationController

  def update
    @geolocation = current_user.geolocation || current_user.create_geolocation
    @geolocation.update(geolocation_params)
    Pusher["user-#{current_user.id}-location"].trigger('update', geolocation_params)
    render nothing: true
  end

  #  ===================
  #  = Private methods =
  #  ===================
  private
    def geolocation_params
      params.require(:geolocation).permit(:latitude, :longitude)
    end

end
