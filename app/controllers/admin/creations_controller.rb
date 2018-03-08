class Admin::CreationsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  
  def new
    @category = Category.new
    @active_product = @category.products.new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    redirect_to admin_root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url, category_ids: [])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end

end
