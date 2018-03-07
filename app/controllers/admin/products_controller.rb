class Admin::ProductsController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Product was successfully created"
      redirect_to admin_products_path
    else
      flash.now[:alert] = "Product creation was unsuccessful"
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Product was successfully updated"
      redirect_to admin_product_path(@product)
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

  def add_to_cart
    $redis.hincrby current_user.id, params[:id], 1
    redirect_to categories_path
    flash[:notice] = "Product added to cart!"
  end

  def remove_from_cart
    if ($redis.hget current_user.id, params[:id]).to_i > 0
      $redis.hincrby current_user.id, params[:id], -1
      redirect_to categories_path
      flash.now[:alert] = "Product removed"
    else
      $redis.hdel current_user.id, params[:id]
      redirect_to categories_path
      flash.now[:alert] = "No such product in cart"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :filestack_url)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
