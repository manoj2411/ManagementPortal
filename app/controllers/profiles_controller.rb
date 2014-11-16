class ProfilesController < ApplicationController

  def update
    current_user.update(user_params)
    redirect_to :back, notice: 'Profile updated successfully.'
  end

  #  ===================
  #  = Private methods =
  #  ===================
  private
    def user_params
      params.require(:profile).permit(:name)
    end

end
