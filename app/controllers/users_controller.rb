class UsersController < ApplicationController
  before_action :authorise_manager_or_data_moderator, only: [:index, :show]
  before_action :authorise_manager, only: [:new, :create, :update, :destroy, :edit]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.select([:id, :name, :email, :role, :phone])
  end

  # GET /users/1
  # def show;end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  # def edit;end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.password = 'testing'

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  #  ===================
  #  = Private methods =
  #  ===================

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      if @user and @user.persisted? and !@user.manager?
        params.require(:user).permit(:email, :name, :role, :blocked)
      else
        params.require(:user).permit(:email, :name, :role)
      end
    end

end
