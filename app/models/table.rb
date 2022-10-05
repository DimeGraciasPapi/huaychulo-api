class Table < ApplicationRecord
  validates :pavilion, presence: true
  validates :code, presence: true, uniqueness: true
  validates :chairs, numericality: { greater_than: 0 }, allow_blank: true
  validates :image, presence: true
  validates :available, inclusion: { in: [ true, false ] }

  has_many :orders, dependent: :nullify
end
