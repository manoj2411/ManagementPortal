class Comment < ActiveRecord::Base
  has_ancestry

  attr_accessor :task_status

  belongs_to :task
  belongs_to :user

  validates :message, :task_id, :user_id, presence: true

  #  ====================
  #  = Instance methods =
  #  ====================
  def update_task_status_and_append_status_change_text(task, user)
    task.update(status: task_status)
    append_status_change_text(user)
  end

  def append_status_change_text(user)
    self.message = message.to_s + "<br> -- <br> <small> Status updated to '#{task_status}' by #{user.name_with_email}</small>"
  end

end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  message    :text
#  task_id    :integer
#  user_id    :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#
