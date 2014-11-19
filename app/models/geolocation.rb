class Geolocation < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: geolocations
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
