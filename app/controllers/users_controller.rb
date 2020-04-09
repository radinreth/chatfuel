class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = policy_scope(User)
    respond_to do |format|
      format.html
      format.json { render json: policy(User).roles }
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def show
  end

  def create
    @user = User.new(user_params)

    authorize @user
    # TODO: remove #skip_confirmation!
    @user.skip_confirmation!
    byebug
    if @user.save
      redirect_to users_path, status: :moved_permanently, notice: "Created successfully"
    else
      render :new, alert: "created failed"
    end
  end

  def update
    authorize @user
    @user.skip_reconfirmation!

    if @user.update(user_params)
      redirect_to @user, status: :moved_permanently, notice: "update successfully"
    else
      render :edit, alert: "update failed"
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, status: :moved_permanently, notice: "delete successfully"
  end

  private
    def set_user
      @user ||= User.find(params[:id])
    end

    def user_params
      status = params[:user][:status].to_i
      role_id = params[:user][:role_id].to_i

      params.require(:user).permit(:role_id, :status, :site_id, :email, :password, :password_confirmation).merge(status: status, role_id: role_id)
    end
end
