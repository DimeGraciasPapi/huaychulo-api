class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :dishes, denpendent: :destroy
end
