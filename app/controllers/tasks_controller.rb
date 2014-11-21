class TasksController < ApplicationController
  before_action :authorize_to_manage, only: [:new, :create, :destroy, :edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  # GET /tasks
  def index
    @tasks = Task.all.order_by_status
  end

  # GET /tasks/1
  def show
    @comments = @task.comments.arrange(order: :created_at)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.assigned_by = current_user if @task.assigned_to
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    @task.assign_attributes(task_params)
    @task.assigned_by = current_user if @task.assigned_to_id_changed?
    if @task.save
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end


  #  ===================
  #  = Private methods =
  #  ===================
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description, :status, :priority, :due_date, :assigned_to_id)
    end

    def authorize_to_manage
      redirect_to root_path, alert: 'Access denied' unless current_user.can_manage_tasks?
    end
end
