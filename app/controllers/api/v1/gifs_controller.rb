class Api::V1::GifsController < Api::V1::BaseController
  before_action :set_gif, only: [:show, :update, :destroy]

  def index
    @gifs = Gif.recent.page(page)

    set_pagination_headers @gifs

    render json: @gifs, each_serializer: Api::V1::GifSerializer
  end

  def show
    render json: @gif, serializer: Api::V1::GifSerializer
  end

  def create
    @gif = Gif.new(gif_params)

    if @gif.save
      render json: @gif, serializer: Api::V1::GifSerializer, status: :created
    else
      render json: { errors: @gif.errors }, success: false, status: :unprocessable_entity
    end
  end

  def update
    if @gif.update_attributes(gif_params)
      render json: @gif, serializer: Api::V1::GifSerializer
    else
      render json: { errors: @gif.errors }, success: false, status: :unprocessable_entity
    end
  end

  def destroy
    if @gif.destroy
      head :no_content
    else
      render json: { errors: @gif.errors }, success: false, status: :unprocessable_entity
    end
  end

  private
  def set_gif
    @gif = Gif.find_by!(external_id: params[:id])
  end

  def gif_params
    params.require(:gif).permit(:url, :tag_list)
  end

  def set_pagination_headers(collection)
    response.headers['X-Total']       = collection.total_count
    response.headers['X-Per-Page']    = collection.limit_value
    response.headers['X-Page']        = collection.current_page
    response.headers['X-Total-Pages'] = collection.total_pages
  end
end