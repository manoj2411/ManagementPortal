class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => ['facebook', 'twitter', 'google_oauth2']

  has_many :authorizations, dependent: :destroy
  has_many :tasks, foreign_key: 'assigned_to_id'
  has_one  :geolocation, dependent: :destroy


  scope :data_collection_executive, -> { where role: 3 }


  #  =================
  #  = Class methods =
  #  =================
  def self.from_omniauth(auth, user = nil)
    user = find_by email: auth.info.email unless user

    if user
      authorization = Authorization.find_or_initialize_by(provider: auth.provider, uid: auth.uid, user_id: user.id)
    elsif auth.provider == 'twitter'
      authorization = Authorization.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
      user = authorization.user
    end

    if authorization
      authorization.token  = auth.credentials.token
      authorization.secret = auth.credentials.secret
      authorization.save
      user
    else
      nil
    end
  end

  #  ====================
  #  = Instance methods =
  #  ====================

  # It'll create 3 methods
  # => manager?, data_moderator? and data_collection_executive?
  %w{ manager data_moderator data_collection_executive }.each_with_index do |name, indx|
    define_method "#{name}?" do
      role == indx + 1
    end
  end

  def manager_or_data_moderator?
    data_moderator? or manager?
  end

  def can_manage_tasks?
    manager? or data_moderator?
  end

  def can_update_task?(task)
    can_manage_tasks? or task_assigned?(task)
  end

  def task_assigned?(task)
    task.assigned_to == self
  end

  def role_name
    case role
      when 1 then 'Manager'
      when 2 then 'Data Moderator'
      when 3 then 'Data Collection Executive'
    end
  end

  def name_with_email
    "#{name} (#{email})"
  end


end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  name                   :string(255)
#  role                   :integer
#  created_at             :datetime
#  updated_at             :datetime
#  blocked                :boolean
#
