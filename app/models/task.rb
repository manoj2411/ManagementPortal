class Task < ActiveRecord::Base

  belongs_to :assigned_to, class_name: 'User'
  belongs_to :assigned_by, class_name: 'User'

  has_many :comments

  validates :title, :description, presence: true

  scope :order_by_status, -> { order('status desc')}
  scope :pending, -> { where status: 'Pending'}
  scope :in_progress, -> { where status: 'In progress'}
  scope :completed, -> { where status: 'Completed'}

end

# == Schema Information
#
# Table name: tasks
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  description    :text
#  status         :string(255)
#  priority       :string(255)
#  due_date       :datetime
#  assigned_to_id :integer
#  assigned_by_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#
