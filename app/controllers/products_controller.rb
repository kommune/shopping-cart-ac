class ProductsController < ApplicationController

  def index
    if current_user
      @cart = $redis.hgetall current_user.id
    else
      session['cart'] ||= []
      @cart = session['cart']
    end
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
