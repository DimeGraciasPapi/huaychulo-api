class Order < ApplicationRecord
  enum status: { pending: 0, delivered: 1, cancelled: 2 }
  
  belongs_to :user
  belongs_to :table
  has_many :order_details, dependent: :destroy
end
