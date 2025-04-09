class CategorySerializer < Blueprinter::Base
  identifier :id

  fields :name, :description

  field :products_count do |category|
    category.products.count
  end

  association :products, blueprint: ProductSerializer, if: ->(_, category, options) { options[:include_products] }
end
