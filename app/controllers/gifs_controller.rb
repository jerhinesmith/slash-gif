class GifsController < ApplicationController
  def index
    @gifs = Gif.recent.includes(:tags).page(page).per(per)
  end
end
