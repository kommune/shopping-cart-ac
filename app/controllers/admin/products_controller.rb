class Admin::ProductsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product was successfully updated"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "Product update was unsuccessful"
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:alert] = "Product was deleted"
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url, category_ids: [])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
