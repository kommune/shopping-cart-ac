module ApplicationHelper

  def total_cart_quantity
    if current_user
      $redis.hvals(current_user.id).map(&:to_i).reduce(:+)
    else
      session['cart'] ||= []
      session['cart'].length
    end
  end

end
