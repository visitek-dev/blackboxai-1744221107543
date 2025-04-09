module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        helpers do
          def authenticate!
            error!('Unauthorized', 401) unless current_user
          end

          def authenticate_admin!
            error!('Forbidden', 403) unless current_user&.admin?
          end

          def current_user
            @current_user ||= User.find_by(id: payload['user_id']) if payload
          end

          def payload
            @payload ||= JWT.decode(token, Rails.application.credentials.secret_key_base).first rescue nil
          end

          def token
            request.headers['Authorization']&.split(' ')&.last
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error_response(message: e.message, status: 400)
        end
      end
    end
  end
end
