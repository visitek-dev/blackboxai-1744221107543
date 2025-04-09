class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, length: { maximum: 500 }

  scope :with_products, -> { joins(:products).distinct }
end
