class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email, :admin

  field :token do |user, options|
    options[:token] || user.generate_jwt
  end
end
