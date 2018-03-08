class Admin::CreationsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product was successfully created"
      redirect_to admin_root_path
    else
      flash.now[:alert] = "Product creation was unsuccessful"
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url)
  end

end
