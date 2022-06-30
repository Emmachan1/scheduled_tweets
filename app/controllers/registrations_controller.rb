class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    User.create(params[:user])
    if @user.save
      redirect_to root_path, notice: "Successfully created account"
    else
      render :new
    end
  end

  def update
    user = current.account.registrations.find(params[:id])
    user.update!(user_params)
    redirect_to user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end