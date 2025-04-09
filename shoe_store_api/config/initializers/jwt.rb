# Configure JWT token settings
Rails.application.config.jwt_secret = Rails.application.credentials.secret_key_base
Rails.application.config.jwt_algorithm = 'HS256'
Rails.application.config.jwt_expiration = 24.hours.to_i
