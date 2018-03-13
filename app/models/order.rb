class Order < ApplicationRecord

  validates :order_number, presence: true, uniqueness: true
  validates :ship_to, presence: true
  validates :order_total, presence: true
  validates :view_order, presence: true
  enum status: [:pending, :confirmed, :shipped]

  belongs_to :user
  has_many :orders_products, dependent: :destroy
  has_many :products, through: :orders_products
  
  has_many :transactions, dependent: :destroy

  def address
    "#{street_name}, #{unit_number}, #{city} #{postal_code}"
  end

end
