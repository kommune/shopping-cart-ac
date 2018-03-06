class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @user = current_user
  end

  def show
    @user = current_user
  end

  def create
  end

  def destroy
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :shipping_address, :billing_address, :contact_number)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
