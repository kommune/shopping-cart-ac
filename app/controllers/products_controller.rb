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

  def add_to_cart
    @product = Product.find(params[:id])
    if current_user
      $redis.hincrby current_user.id, params[:id], 1
      @count = $redis.hget current_user.id, params[:id]
    else
      session['cart'] ||= {}
      session['cart'] << params[:id]
      @count = session['cart'].length
    end
    flash[:notice] = "Product added to cart!"
    redirect_to product_path(@product)
  end

  def remove_from_cart
    @product = Product.find(params[:id])
    if current_user
      if ($redis.hget current_user.id, params[:id]).to_i <= 1
        $redis.hdel current_user.id, params[:id]
      else
      $redis.hincrby current_user.id, params[:id], -1
      end
      @count = $redis.hget current_user.id, params[:id]
    else
      session['cart'].delete(params[:id]) if session['cart']
      @count = session['cart'].length
    end
    flash.now[:alert] = "Product removed from cart"
    redirect_to cart_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

end
