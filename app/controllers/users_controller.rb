class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
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

  private

  def user_params
    params.require(:user).permit(:role, :email, :password, :password_confirmation)
  end
end
