class CartsController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user
    @cart = $redis.hgetall(current_user.id)
    # @products = cart.keys
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
  
end
