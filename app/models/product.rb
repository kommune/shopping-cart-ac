class Product < ApplicationRecord

  has_many :categories_products, dependent: :destroy
  has_many :categories, through: :categories_products

  has_many :orders_products, dependent: :destroy
  has_many :orders, through: :orders_products

  validates :name, presence: true
  validates :price, presence: true
end
