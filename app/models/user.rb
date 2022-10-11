class User < ApplicationRecord
  enum user_type: { client: 0, admin: 1 }
  validates :name, presence: true
  validates :last_name, presence: true
  validates :document, presence: true, uniqueness: true
  enum document_type: { dni: 0, ruc: 1, other: 2 }

  has_secure_token
  has_secure_password
  has_many :orders, dependent: :destroy

  def invalidate_token
    update(token: nil)
  end
end
