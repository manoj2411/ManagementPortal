class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.string :twilio_sid
      t.belongs_to :user, index: true
      t.belongs_to :sent_by, index: true

      t.timestamps
    end
  end
end
