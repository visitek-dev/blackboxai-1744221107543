class Product < ApplicationRecord
  belongs_to :category, optional: true, counter_cache: true

  validates :name, presence: true, length: { maximum: 100 }
  validates :size, presence: true
  validates :color, presence: true
  validates :brand, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :in_stock, -> { where('quantity > 0') }
  scope :by_brand, ->(brand) { where(brand: brand) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end
