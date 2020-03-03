class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    if @user.save
      redirect_to users_path, status: :moved_permanently, notice: 'Created successfully'
    else
      render :new, alert: 'created failed'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.skip_reconfirmation!
    if @user.update(user_params)
      redirect_to @user, status: :moved_permanently, notice: 'update successfully'
    else
      render :show, alert: 'update failed'
    end
  end

  private

  def user_params
    params.require(:user).permit(:role, :status, :email, :password, :password_confirmation)
  end
end
