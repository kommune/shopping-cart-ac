class Admin::OrdersController < ApplicationController

  layout 'admin'
  
  before_action :authenticate_admin!

  def index
    @orders = current_user.orders.all
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "Order was successfully updated"
      redirect_to admin_orders_path
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
    redirect_to admin_orders_path
  end

end
