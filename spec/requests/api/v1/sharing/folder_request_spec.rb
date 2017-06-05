require 'rails_helper'

describe Api::V1::Sharing::FoldersController do
  let!(:application) { create :application }
  let!(:user)        { create :user_with_folders }
  let!(:token)       { create :access_token,
                              :application => application,
                              :resource_owner_id => user.id }
  describe 'GET #index' do
    it 'responds with 200' do
      get '/api/v1/sharing/folders', params: {access_token: token.token}
      expect(response).to be_success
    end

    it "returns list of user's" do
      get '/api/v1/sharing/folders', params: {access_token: token.token}
      folders = JSON.parse(response.body)
      expect(folders.count).to eq(4)
      expect(folders.first).to have_key("name")
      expect(folders.first).to have_key("user_id")
      expect(folders.first).to have_key("folder_id")
      expect(folders.first).to have_key("route")
    end
  end
end
