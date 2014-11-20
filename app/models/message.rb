class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :sent_by, class_name: 'User'

  validates :content, presence: true

  after_commit :send_through_twilio, on: :create

  def send_through_twilio
    # TODO: Move these keys to confign/yml file
    account_sid = "AC35cf20e56a39a506ba2298359e4e1882"
    auth_token = "4fe28944f5ee172263f6864f17f226a9"
    client = Twilio::REST::Client.new account_sid, auth_token
    # TODO: Check and verify number before sending message
    message = client.messages.create( from: '+1 520-447-4041', to: user.phone, body: content)
    update twilio_sid: message.sid
  end
end

# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  twilio_sid :string(255)
#  user_id    :integer
#  sent_by_id :integer
#  created_at :datetime
#  updated_at :datetime
#
