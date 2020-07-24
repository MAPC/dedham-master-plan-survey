class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |e|
    render json: e, status: :unprocessable_entity
  end
end
