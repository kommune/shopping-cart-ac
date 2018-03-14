class CartsController < ApplicationController

  def show
    if current_user
      @user = current_user
      @cart = $redis.hgetall(current_user.id)
    else 
      @cart = session['cart']
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
  

end
