module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults

      resource :auth do
        desc 'Create a new user'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
          optional :admin, type: Boolean, default: false, desc: 'Admin flag'
        end
        post 'signup' do
          user = User.create!(
            email: params[:email],
            password: params[:password],
            admin: params[:admin]
          )
          present user, with: UserSerializer, token: user.generate_jwt
        end

        desc 'Login user'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end
        post 'login' do
          user = User.find_by(email: params[:email])
          if user&.authenticate(params[:password])
            present user, with: UserSerializer, token: user.generate_jwt
          else
            error!('Invalid email or password', 401)
          end
        end
      end
    end
  end
end
