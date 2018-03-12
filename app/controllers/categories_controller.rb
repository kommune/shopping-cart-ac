class CategoriesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_category, only: [:show]
  before_action :set_categoriesproduct, only: [:show, :index]

  def index
  
  end

  def show
    @products = @category.products.all
  end

  private

  def set_categoriesproduct
    @categoriesproduct = CategoriesProduct.where(params[:id])
  end
  
  def categoriesproduct_params
    params.require(:category).permit(:category_id, :product_id)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def set_product
    @product = Product.where(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url)
  end

end
