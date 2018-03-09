class CartController < ApplicationController

  before_action :set_user

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
