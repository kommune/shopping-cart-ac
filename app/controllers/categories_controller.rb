class CategoriesController < ApplicationController

  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @product = Product.find(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url)
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
