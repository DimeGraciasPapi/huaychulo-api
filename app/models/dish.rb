class Dish < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { in: 5..300 }, allow_blank: true
  validates :waiting_time, presence: true, numericality: { greater_than: 0 }
  validates :image, presence: true

  belongs_to :category
  has_many :order_details, dependent: :nullify
end
