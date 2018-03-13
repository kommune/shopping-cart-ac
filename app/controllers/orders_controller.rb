class OrdersController < ApplicationController

  before_action :authenticate_admin!, only: [:update, :edit, :destroy]
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.all
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def checkout # or display new order
    @cart = $redis.hgetall(current_user.id)
    @order = current_user.orders.new
  end

  def create
    @order = current_user.orders.create(order_params)
    redirect_to transactions_new_path
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

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
  
  def order_params
    params.require(:order).permit(:street_name, :unit_number, :city, :postal_code, :contact_number, :order_total, :status)
  end

end
