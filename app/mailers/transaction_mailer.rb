class TransactionMailer < ApplicationMailer

  def successful_email(user)
    @total_cost = user.cart_total_price
    @email = user.email
    @product = Product.first
    mail to: user.email, subject: "Your payment was successful!"
  end

  def unsuccessful_email(user)
    @total_cost = user.cart_total_price
    @email = user.email
    mail to: user.email, subject: "Your payment was unsuccessful!"
  end

end
