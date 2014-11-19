class CreateGeolocations < ActiveRecord::Migration
  def change
    create_table :geolocations do |t|
      t.float :latitude
      t.float :longitude
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
