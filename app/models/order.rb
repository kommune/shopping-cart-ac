class Order < ApplicationRecord

  validates :order_number, presence: true, uniqueness: true
  validates :ship_to, presence: true
  validates :order_total, presence: true
  validates :view_order, presence: true
  enum status: [:pending, :confirmed, :shipped]

  belongs_to :user
  has_many :transactions, dependent: :destroy
end
