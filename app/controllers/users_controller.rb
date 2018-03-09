class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:home, :aboutus, :theprocess, :materialsandcare]
  before_action :set_user, only: [:show, :edit, :update]

  def home
    @user = current_user
  end

  def aboutus

  end

  def theprocess

  end

  def materialsandcare
    
  end

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
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
