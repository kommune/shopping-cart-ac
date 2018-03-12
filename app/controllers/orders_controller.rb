class OrdersController < ApplicationController

  before_action :authenticate_admin!, only: [:update, :edit, :destroy]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.all
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = current_user.orders.new
  end

  def checkout # or show new order
    @cart = $redis.hgetall(current_user.id)
    @order = Order.create(order_params)
    @order.ship_to = current_user.address
    @order.order_total = cart.each { |product_id , qty|
      product = Product.find(product_id)  
      product.price * qty
    }.reduce(:+)
    @cart = $redis.hdel(current_user.id, product_id)
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "Order was successfully updated"
      redirect_to user_orders_path
    else
      flash.now[:alert] = "Order update was unsuccessful"
      render :edit
    end
  end

  def edit
    @order = current_user.orders.find(params[:id])
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    @order.destroy
    flash[:alert] = "Order was deleted"
    redirect_to user_orders_path
  end

  def pending
    @orders = current_user.orders.where(status = 0)
  end

  def confirmed
    @orders = current_user.orders.where(status = 1)
  end

  def shipped
    @orders = current_user.orders.where(status = 2)
  end

  private

  def order_params
    params.require(:order).permit(:ship_to, :order_total, :view_order, :status)
  end

end
