class MessagesController < ApplicationController
  before_action :authorise_manager_or_data_moderator
  before_action :set_user, only: [:create, :new]

  def new
    @message = Message.new
    respond_to do |format|
      format.js { } # render :new
    end
  end

  def create
    @message = @user.messages.build(message_params)
    @message.sent_by = current_user
    respond_to do |format|
      if @message.save
        format.js { render js: 'pushAlert("Mesage sent successfully.");$(".message_modal").modal("hide");'}
      else
        format.js { render :new }
      end
    end
  end

  #  ===================
  #  = Private methods =
  #  ===================
  private
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content)
    end
end
