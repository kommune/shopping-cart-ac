class Admin::CategoriesController < ApplicationController

  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @products = Product.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Category creation was unsuccessful"
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category was successfully updated"
      redirect_to admin_category_path(@category)
    else
      flash.now[:alert] = "Category update was unsuccessful"
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "Category was deleted"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url)
  end

end
