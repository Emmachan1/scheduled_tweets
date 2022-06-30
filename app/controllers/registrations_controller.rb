class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new sign_up_path
    if @user.save
      redirect_to root_path, notice: "Successfully created account"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
    params[:user]
  end
end