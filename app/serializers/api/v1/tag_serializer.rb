class Api::V1::TagSerializer < ApplicationSerializer
  attributes :name, :taggings_count
end
