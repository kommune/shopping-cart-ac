class UsersController < ApplicationController

  validates :shipping_address, presence: true
  validates :billing_address, presence: true
  validates :contact_number, presence: true
end
