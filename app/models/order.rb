class Order < ApplicationRecord

  validates :street_name, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validates :contact_number, presence: true
  validates :order_total, presence: true

  enum status: [:pending, :confirmed, :shipped]

  belongs_to :user
  has_many :orders_products, dependent: :destroy
  has_many :products, through: :orders_products
  
  has_many :transactions, dependent: :destroy

  def ship_to
    "#{street_name}, #{unit_number}, #{city} #{postal_code}"
  end

end
