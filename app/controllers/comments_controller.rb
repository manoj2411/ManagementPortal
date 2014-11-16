class CommentsController < ApplicationController
  before_action :set_task, only: [:create, :new]

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
    respond_to do |format|
      format.js { }
    end
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.assign_attributes user: current_user, task: @task
    @comment.update_task_status_and_append_status_change_text(@task, current_user) if @comment.task_status != @task.status
    respond_to do |format|
      if @comment.save
        @comments =  @task.comments.arrange(order: :created_at)
        format.js { }
      else
        format.js { render (@comment.root? ? :create : :new)}
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    end
  end

  #  ===================
  #  = Private methods =
  #  ===================
  private

    def set_task
      @task = Task.find(params[:task_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:message, :parent_id, :task_status)
    end
end
