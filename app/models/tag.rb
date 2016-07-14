class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :gifs, through: :taggings, source: :gif
end
