module TaskHelper
  def assigned_to_name_for_task(task)
    task.assigned_to ? (task.assigned_to.name || task.assigned_to.email) : 'Nobody'
  end

  def assigned_by_name_for_task(task)
    task.assigned_by ? (task.assigned_by.name || task.assigned_by.email) : 'NA'
  end

  def formatted_task_due_date(task)
    task.due_date.strftime('%d-%b-%Y, %l:%M %p')
  end
end
