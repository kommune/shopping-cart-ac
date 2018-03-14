module ApplicationHelper

  def total_cart_quantity
    if current_user
      $redis.hvals(current_user.id).map(&:to_i).reduce(:+)
    else
      session[:cart] ||= {}
      @count = 0
      session[:cart].each {|product_ids, qty| @count += qty }
      @count
    end
  end

end
