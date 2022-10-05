class OrderDetail < ApplicationRecord
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  belongs_to :dish
  belongs_to :order
end
