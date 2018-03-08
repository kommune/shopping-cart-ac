class Admin::ProductsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Product was successfully updated"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "Product update was unsuccessful"
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:alert] = "Product was deleted"
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
