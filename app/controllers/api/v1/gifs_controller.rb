class Api::V1::GifsController < Api::V1::BaseController
  before_action :set_gif, only: [:show, :update, :destroy]

  def index
    @gifs = Gif.recent.page(page).per(per)

    set_pagination_headers @gifs

    render json: @gifs, each_serializer: Api::V1::GifSerializer
  end

  def show
    render json: @gif, serializer: Api::V1::GifSerializer
  end

  def random
    @gif = Gif.random(Array(params[:tag].to_s.split(/\s+/)))

    render json: @gif, serializer: Api::V1::GifSerializer
  end

  def create
    @gif = Gif.where(url: gif_params['url']).first_or_create
    @gif.tag_list.add(gif_params['tag_list'], parse: true)

    if @gif.persisted?
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
end