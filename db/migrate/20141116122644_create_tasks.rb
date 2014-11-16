class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :priority
      t.datetime :due_date
      t.belongs_to :assigned_to, index: true
      t.belongs_to :assigned_by, index: true

      t.timestamps
    end
  end
end
