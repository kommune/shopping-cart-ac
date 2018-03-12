module ApplicationHelper

  def total_cart_quantity
    $redis.hvals(current_user.id).map(&:to_i).reduce(:+)
  end

end
