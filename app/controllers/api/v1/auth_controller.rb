class Api::V1::AuthController < Api::V1::ApiController

    skip_before_action :authenticate_token

    def create
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
            render json: {token: JsonWebToken.encode({user: user.id})}, status: :ok
        else
            render json: {errors: ["Invalid email/password"]}, status: :unauthorized
        end
    end
end