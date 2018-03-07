class Category < ApplicationRecord

  has_many :products, through: :categories_products
  has_many :categories_products, dependent: :destroy

  enum status: [:new_arrivals, :best_sellers, :rings, :necklaces, :earrings, :bracelets]

end
