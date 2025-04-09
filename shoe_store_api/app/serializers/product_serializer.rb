class ProductSerializer < Blueprinter::Base
  identifier :id

  fields :name, :size, :color, :brand, :price, :quantity

  field :in_stock do |product|
    product.quantity > 0
  end

  association :category, blueprint: CategorySerializer, if: ->(_, product, _) { product.category.present? }
end
