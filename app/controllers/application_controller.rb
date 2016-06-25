class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def set_pagination_headers(collection)
    response.headers['X-Total']       = collection.total_count
    response.headers['X-Per-Page']    = collection.limit_value
    response.headers['X-Page']        = collection.current_page
    response.headers['X-Total-Pages'] = collection.total_pages
  end

  def page
    Integer(params[:page] || 1)
  end

  def per
    Integer(params[:per] || 25)
  end
end
