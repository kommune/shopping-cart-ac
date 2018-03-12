class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @total_cart_quantity = total_cart_quantity
  end

  def add_to_cart
    @product = Product.find(params[:id])
    $redis.hincrby current_user.id, params[:id], 1
    @count = $redis.hget current_user.id, params[:id]
    flash[:notice] = "Product added to cart!"
  end

  def remove_from_cart
    if ($redis.hget current_user.id, params[:id]).to_i > 0
      $redis.hincrby current_user.id, params[:id], -1
      flash.now[:alert] = "Product removed"
    else
      $redis.hdel current_user.id, params[:id]
      flash.now[:alert] = "No such product in cart"
    end
  end

  private

  def total_cart_quantity
    $redis.hvals(current_user.id).map(&:to_i).reduce(:+)
  end

end
