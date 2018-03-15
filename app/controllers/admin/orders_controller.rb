class Admin::OrdersController < ApplicationController

  layout 'admin'
  
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @products = @order.products.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "Order was successfully updated"
      redirect_to admin_orders_path
    else
      flash.now[:alert] = "Order update was unsuccessful"
      render :edit
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:alert] = "Order was deleted"
    redirect_to admin_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:street_name, :unit_number, :city, :postal_code, :contact_number, :order_total, :quantity, :status)
  end

end
