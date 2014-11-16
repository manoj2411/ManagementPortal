class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.belongs_to :user, index: true
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
