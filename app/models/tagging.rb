class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :gif, foreign_key: :taggable_id
end
