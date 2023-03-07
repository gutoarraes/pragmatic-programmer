class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Thanks for signing up"
      redirect_to @user
    else
      render new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'User successfully deleted'
    redirect_to users_url, status: :see_other
  end

  private

  def user_params
    params.require(:user).
      permit(:name, :email, :password, :password_confirmation)
  end
end
