module API
  module V1
    class Categories < Grape::API
      include API::V1::Defaults

      resource :categories do
        desc 'Return all categories'
        params do
          optional :include_products, type: Boolean, default: false, desc: 'Include associated products'
        end
        get do
          categories = Category.all
          present categories, with: CategorySerializer, include_products: params[:include_products]
        end

        desc 'Return a specific category'
        params do
          requires :id, type: Integer, desc: 'Category ID'
          optional :include_products, type: Boolean, default: false, desc: 'Include associated products'
        end
        get ':id' do
          category = Category.find(params[:id])
          present category, with: CategorySerializer, include_products: params[:include_products]
        end

        desc 'Create a category'
        params do
          requires :category, type: Hash do
            requires :name, type: String
            optional :description, type: String
          end
        end
        post do
          authenticate_admin!
          category = Category.create!(params[:category])
          present category, with: CategorySerializer
        end
      end
    end
  end
end
