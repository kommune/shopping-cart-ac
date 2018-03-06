class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
  end

  def show
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def product_params
    params.require(:user).permit(:name, :price, :description, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
