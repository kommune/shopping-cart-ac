class OrdersController < ApplicationController

  before_action :authenticate_user!

  def index
    @orders = current_user.orders.all
  end

  def show
    @order = current_user.orders.find(params[:id])
    @products = @order.products.all
  end

  def checkout # or display new order
    @cart = $redis.hgetall(current_user.id)
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      redirect_to new_order_transaction_path(@order)
    else
      @cart = $redis.hgetall(current_user.id)
      render :checkout
    end
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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
  
  def order_params
    params.require(:order).permit(:street_name, :unit_number, :city, :postal_code, :contact_number, :order_total, :status)
  end

end
