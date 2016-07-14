class GifsController < ApplicationController
  def index
    @tags = Tag.joins(:gifs).order('tags.name asc').page(page).per(per)
  end
end
