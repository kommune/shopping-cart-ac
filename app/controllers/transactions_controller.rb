class TransactionsController < ApplicationController

  before_action :authenticate_user!
  before_action :prepare_order

  def new
    gon.client_token = generate_client_token
  end

  def create
    @result = Braintree::Transaction.sale(
      amount: current_user.total_cart_value,
      payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      TransactionMailer.successful_email(current_user).deliver_later 
      current_user.purchase_cart_products!(@order)
      redirect_to user_order_path(current_user, @order)
    else
      TransactionMailer.unsuccessful_email(current_user).deliver_later 
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      @order.transactions.create(status: "unsuccessful")
      render :new
    end
  end

  private

  def generate_client_token
    Braintree::ClientToken.generate
  end

  def prepare_order
    @order = Order.find(params[:order_id])
  end

end
