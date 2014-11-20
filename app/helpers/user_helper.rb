module UserHelper
  def new_message_link(user)
    link_to "#{user.phone} - sms", new_user_message_path(user), remote: true
  end
end
