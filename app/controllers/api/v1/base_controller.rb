class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def record_not_found(exception)
    render json: { error: :not_found, message: exception.message }, status: :not_found
  end
end
