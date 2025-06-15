class Api::V1::ApiController < ApplicationController

    attr_reader :current_user

    skip_before_action :verify_authenticity_token
    before_action :set_json_format, :authenticate_token

    private

    def authenticate_token
        begin
            payload = JsonWebToken.decode(self.auth_token)
            @current_user = User.find(payload[0]["user"])

        rescue => e
            p e.to_s
            render json: {error: "401 Unauthorized"}, status: :unauthorized
        end
    end

    def auth_token
        @auth_token ||= request.headers["Authorization"]&.split(" ")&.last
        return @auth_token
    end

    def set_json_format
        request.format = :json
    end
end