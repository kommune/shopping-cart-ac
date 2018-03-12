class CartsController < ApplicationController

  def show
    @user = current_user
    @cart = $redis.hgetall(current_user.id)
    @product_ids = $redis.hkeys(current_user.id)
    @products = Product.find(@product_ids)
  end

  def add
    @product = Product.find(params[:product_id])
    $redis.hincrby current_user.id, params[:product_id], 1
    @count = $redis.hget current_user.id, params[:product_id]
    flash[:notice] = "Product added to cart!"
    redirect_to product_path(@product)
  end

  def remove
    @product = Product.find(params[:product_id])
    if $redis.hget current_user.id, params[:product_id] == 1
      $redis.hdel current_user.id, params[:product_id]
    else
    $redis.hincrby current_user.id, params[:product_id], -1
    end
    @count = $redis.hget current_user.id, params[:product_id]
    flash.now[:alert] = "Product removed from cart"
    redirect_to product_path(@product)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
  
  def current_user_cart
    "cart#{current_user.id}"
  end

end
