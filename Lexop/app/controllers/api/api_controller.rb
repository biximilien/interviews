class API::APIController < ApplicationController
    rescue_from ActionController::RoutingError, with: :not_found

    def not_found
        render json: { error: {
            message: 'Not Found',
            status_code: 404
        }}, status: 404
    end

    def bad_request
        render json: { error: {
            message: 'Bad Request',
            status_code: 400
        }}, status: 400
    end
end