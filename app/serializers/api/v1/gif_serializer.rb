class Api::V1::GifSerializer < ApplicationSerializer
  attribute :external_id, key: :id
  attributes :url
end
