class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        user = User.create(first_name: data['first_name'],
           last_name: data['last_name'],
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
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

  def purchase_cart_products!(order)
    get_cart_products.each { |product| order.products << product }
    $redis.del id
    transaction = order.transactions.create(status: "successful")
  end

  # def purchase(product)
  #   products << order unless purchase?(product)
  # end

  # def purchase?(product)
  #   products.include?(product)
  # end

  def get_cart_products
    cart_ids = $redis.hkeys id
    Product.find(cart_ids)
  end

end
