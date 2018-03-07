class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :shipping_address, presence: true
  validates :billing_address, presence: true
  validates :contact_number, presence: true
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
end
