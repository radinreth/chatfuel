class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @pagy, @users = pagy(User.all)
    authorize @users
    @user = User.new
    @roles = Role.distinct

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

  def update
    authorize @user
    @user.skip_reconfirmation!

    if @user.update(user_params)
      redirect_to @user, status: :moved_permanently, notice: t("updated.success")
    else
      render :edit, alert: t("updated.fail")
    end
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path, status: :moved_permanently, notice: t("deleted.success")
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
