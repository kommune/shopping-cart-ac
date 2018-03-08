class Category < ApplicationRecord

  has_many :categories_products, dependent: :destroy
  has_many :products, through: :categories_products

  enum name: [:new_arrivals, :best_sellers, :rings, :necklaces, :earrings, :bracelets]

end
