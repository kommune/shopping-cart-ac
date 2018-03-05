class Transaction < ApplicationRecord

  belongs_to :order

  enum status: [:unsuccessful, :successful]
  
end
