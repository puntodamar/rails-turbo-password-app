module JsonWebToken
    SECRET_KEY = Rails.application.credentials.dig(:secret_key_base)

    class << self
        def encode(payload, exp = 2.minutes.from_now.to_i)
            payload[:exp] = exp
            JWT.encode(payload, SECRET_KEY,)
        end

        def decode(token)
            JWT.decode(token, SECRET_KEY)
        end
    end

end