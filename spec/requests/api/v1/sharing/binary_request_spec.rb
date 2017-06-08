require 'rails_helper'

describe Api::V1::Sharing::BinariesController do
  let!(:application) { create :application }
  let!(:user)        { create :user_with_various_binary_types }
  let!(:token)       { create :access_token,
                              :application => application,
                              :resource_owner_id => user.id }
  describe 'GET #index' do
    it 'responds with 200' do
      get '/api/v1/sharing/binaries', params: {access_token: token.token}
      expect(response).to be_success
    end

    it "returns list of user's binaries" do
      get '/api/v1/sharing/binaries', params: {access_token: token.token}
      binaries = JSON.parse(response.body)

      expect(binaries.count).to eq(4)
      expect(binaries.first).to have_key("name")
      expect(binaries.first).to have_key("extension")
      expect(binaries.first).to have_key("folder_id")
      expect(binaries.first).to have_key("data_url")
    end
  end

  describe "GET #show" do
    it 'responds with 200' do
      binary = user.binaries.first

      get "/api/v1/sharing/binaries/#{binary.id}", params: {access_token: token.token}

      expect(response).to be_success
    end
    it 'returns contents of a specific folder' do
      binary = user.binaries.first

      get "/api/v1/sharing/binaries/#{binary.id}", params: {access_token: token.token}
      contents = JSON.parse(response.body)

      expect(contents).to have_key("name")
      expect(contents).to have_key("extension")
      expect(contents).to have_key("data_url")
      expect(contents).to have_key("folder_id")
    end
  end
end
