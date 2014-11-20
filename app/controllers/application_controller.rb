class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :verify_blocked_user

  #  ===================
  #  = Private methods =
  #  ===================
  private

    def verify_blocked_user
      if current_user and current_user.blocked?
        sign_out current_user
        redirect_to new_user_session_path, alert: 'You account has been blocked. Please contact Manager.'
      end
    end

    def authorise_manager
      redirect_to root_path, alert: 'Access denied' unless current_user.manager?
    end
end
