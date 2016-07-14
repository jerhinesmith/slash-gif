class GifsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.order(:name).includes(taggings: :taggable).page(page).per(per)
  end
end
