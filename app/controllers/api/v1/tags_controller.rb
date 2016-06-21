class Api::V1::TagsController < Api::V1::BaseController
  before_action :set_tag, only: [:show]

  def index
    @tags = ActsAsTaggableOn::Tag.order(:name).page(page)

    set_pagination_headers @tags

    render json: @tags, each_serializer: Api::V1::TagSerializer
  end

  def show
    render json: @tag, serializer: Api::V1::TagSerializer
  end

  private
  def set_tag
    @tag = ActsAsTaggableOn::Tag.find_by!(name: params[:id])
  end
end
