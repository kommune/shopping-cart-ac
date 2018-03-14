class CartsController < ApplicationController

  def show
    if current_user
      @user = current_user
      @cart = $redis.hgetall(current_user.id)
    else 
      @cart = session[:cart]
    end
  end

  def add
    @product = Product.find(params[:product_id])
    if current_user
      $redis.hincrby current_user.id, params[:product_id], 1
      @count = $redis.hget current_user.id, params[:product_id]
    else
      session[:cart] ||= {}
      session[:cart][params[:product_id]] ||= 0
      session[:cart][params[:product_id]] += 1
      @count = 0
      session[:cart].each {|product_ids, qty| @count += qty }
    end
    flash[:notice] = "Product added to cart!"
    redirect_to product_path(@product)
  end

  def remove
    @product = Product.find(params[:product_id])
    if current_user
      if ($redis.hget current_user.id, params[:product_id]).to_i <= 1
        $redis.hdel current_user.id, params[:product_id]
      else
      $redis.hincrby current_user.id, params[:product_id], -1
      end
      @count = $redis.hget current_user.id, params[:product_id]
    else
      if session[:cart][params[:product_id]] <= 1
        session[:cart].delete(params[:product_id])
      else
        session[:cart][params[:product_id]] -= 1
      end
      @count = 0
      session[:cart].each {|product_ids, qty| @count += qty }
    end
    flash.now[:alert] = "Product removed from cart"
    redirect_to cart_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
  

end
