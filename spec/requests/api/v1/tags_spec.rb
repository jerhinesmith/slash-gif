require 'rails_helper'

describe "api/v1/tags", type: :request do
  before(:each) do
    set_api_version 1
  end

  context "index" do
    before do
      FactoryGirl.create_list(:tag, 3)
    end

    let(:url) { "/api/tags" }

    it "json" do
      get url

      expect(response).to be_success
      expect(json.length).to eq 3
      expect(json).to all( be_serialized_with Api::V1::TagSerializer )
    end
  end

  context "show" do
    before do
      @tag = FactoryGirl.create(:tag)
    end

    let(:url) { "/api/tags/#{@tag.name}" }

    it "json" do
      get url

      expect(response).to be_success
      expect(json).to be_serialized_with Api::V1::TagSerializer
    end
  end
end
