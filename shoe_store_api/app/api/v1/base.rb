module API
  module V1
    class Base < Grape::API
      include API::V1::Defaults

      mount API::V1::Auth
      mount API::V1::Products
      mount API::V1::Categories

      add_swagger_documentation(
        api_version: 'v1',
        hide_documentation_path: true,
        info: {
          title: 'Shoe Store API',
          description: 'API for managing shoe inventory and categories'
        }
      )
    end
  end
end
