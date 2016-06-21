require 'rails_helper'

describe "api/v1/gifs", type: :request do
  before(:each) do
    set_api_version 1
  end

  context "index" do
    before do
      FactoryGirl.create_list(:gif, 3)
    end

    let(:url) { "/api/gifs" }

    it "json" do
      get url

      expect(response).to be_success
      expect(json.length).to eq 3
      expect(json).to all( be_serialized_with Api::V1::GifSerializer )
    end
  end

  context "show" do
    before do
      @gif = FactoryGirl.create(:gif)
    end

    let(:url) { "/api/gifs/#{@gif.external_id}" }

    it "json" do
      get url

      expect(response).to be_success
      expect(json).to be_serialized_with Api::V1::GifSerializer
    end
  end

  context "create" do
    let(:url) { "/api/gifs" }

    it "successful JSON" do
      post url, {
        gif: {
          url:      Faker::Internet.url,
          tag_list: Faker::Lorem.words.join(',')
        }
      }

      expect(response).to be_success
      expect(response).to have_http_status(:created)
      expect(json).to be_serialized_with Api::V1::GifSerializer
    end

    it "error JSON" do
      post url, { gif: { url: nil } }

      expect(response).not_to be_success
      expect(response).to have_http_status(:unprocessable_entity)

      expect(json.keys).to match_array(['errors'])
      expect(json['errors'].length).to be > 0
    end
  end

  context "update" do
    before do
      @gif = FactoryGirl.create(:gif)
    end

    let(:url) { "/api/gifs/#{@gif.external_id}" }

    it "successful JSON" do
      patch url, {
        gif: { url: Faker::Internet.url }
      }

      expect(response).to be_success
    end

    it "error JSON" do
      patch url, {
        gif: { url: nil }
      }

      expect(response).not_to be_success
      expect(response).to have_http_status(:unprocessable_entity)

      expect(json.keys).to match_array(['errors'])
      expect(json['errors'].length).to be > 0
    end

    it "not found" do
      patch url.gsub(@gif.external_id.to_s, '-1'), {
        gif: { url: Faker::Internet.url }
      }

      expect(response).to have_http_status(:not_found)
    end
  end

  context "destroy" do
    before do
      @gif = FactoryGirl.create(:gif)
    end

    let(:url) { "/api/gifs/#{@gif.external_id}" }

    it "successful JSON" do
      delete url

      expect(response).to be_success
      expect(response).to have_http_status(:no_content)
    end

    it "not found" do
      delete url.gsub(@gif.external_id.to_s, '-1')

      expect(response).to have_http_status(:not_found)
    end
  end
end
