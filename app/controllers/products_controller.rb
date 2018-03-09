class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    $redis.hincrby current_user.id, params[:id], 1
    redirect_to categories_path
    flash[:notice] = "Product added to cart!"
  end

  def remove_from_cart
    if ($redis.hget current_user.id, params[:id]).to_i > 0
      $redis.hincrby current_user.id, params[:id], -1
      redirect_to categories_path
      flash.now[:alert] = "Product removed"
    else
      $redis.hdel current_user.id, params[:id]
      redirect_to categories_path
      flash.now[:alert] = "No such product in cart"
    end
  end

  private



end
