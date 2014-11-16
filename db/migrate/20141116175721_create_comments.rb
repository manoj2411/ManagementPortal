class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.belongs_to :task, index: true
      t.belongs_to :user, index: true
      t.string :ancestry

      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
