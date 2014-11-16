class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!

  def provider
    user = User.from_omniauth(request.env["omniauth.auth"], current_user)
    if current_user
      redirect_to edit_profile_url, notice: "#{action_name.capitalize} connected to your account successfully."
    elsif user
      sign_in_and_redirect(user, event: :authentication)
      set_flash_message(:notice, :success, kind: action_name) if is_navigational_format?
    else
      redirect_to new_user_session_url, alert: 'No account found. Please contact admin.'
    end
  end

  def failure
    super
  end


  alias_method :facebook, :provider
  alias_method :twitter, :provider
  alias_method :google_oauth2, :provider
end
