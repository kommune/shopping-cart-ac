class TransactionsController < ApplicationController

  before_action :authenticate_user!

  def new
    gon.client_token = generate_client_token
  end

  def create
    @result = Braintree::Transaction.sale(
      amount: current_user.cart_total_price,
      payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      TransactionMailer.successful_email(current_user.email).deliver_later 
      current_user.purchase_cart_products!
      redirect_to root_url, notice: "Congratulations! Your transaction was successful!"
    else
      TransactionMailer.unsuccessful_email(current_user.email).deliver_later 
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      render :new
    end
  end

  private

  def generate_client_token
    Braintree::ClientToken.generate
  end

end
