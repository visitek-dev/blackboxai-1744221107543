module API
  module V1
    class Products < Grape::API
      include API::V1::Defaults

      resource :products do
        desc 'Return all products'
        get do
          products = Product.all
          present products, with: ProductSerializer
        end

        desc 'Return a specific product'
        params do
          requires :id, type: Integer, desc: 'Product ID'
        end
        get ':id' do
          product = Product.find(params[:id])
          present product, with: ProductSerializer
        end

        desc 'Create a product'
        params do
          requires :product, type: Hash do
            requires :name, type: String
            requires :size, type: String
            requires :color, type: String
            requires :brand, type: String
            requires :price, type: BigDecimal
            requires :quantity, type: Integer
            optional :category_id, type: Integer
          end
        end
        post do
          authenticate_admin!
          product = Product.create!(params[:product])
          present product, with: ProductSerializer
        end

        # Additional endpoints for update/delete will be added here
      end
    end
  end
end
