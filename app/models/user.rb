class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def total_cart_value 
    total_price = 0
    $redis.hgetall(id).each do |product_id, qty|
      product = Product.find(product_id)  
      total_price += product.price * qty.to_i
    end
    total_price
  end
  
  def current_cart
    $redis.smembers "cart#{self.id}"
  end

  def purchase_cart_products!
    get_cart_products.each { |product| purchase(product) }
    $redis.del "cart#{id}"
  end

  def purchase(product)
    products << product unless purchase?(product)
  end

  def purchase?(product)
    products.include?(product)
  end

  def get_cart_products
    cart_ids = $redis.hkeys id
    Product.find(cart_ids)
  end

end
