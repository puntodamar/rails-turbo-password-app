class Api::V1::EntriesController <  Api::V1::ApiController
    def index
        render json: current_user.entries
    end
end