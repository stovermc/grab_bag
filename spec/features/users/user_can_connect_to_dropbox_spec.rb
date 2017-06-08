require 'rails_helper'

RSpec.feature "User can connect to dropbox" do
  context "As a logged in User who also has a dropbox account" do
    scenario "I can connect to my dropbox account" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user.home.url
      click_on 'Connect to Dropbox'

      expect(current_path).to eq('/oauth2/authorize')
    end
      # expect(current_path).to eq(dropbox_auth_callback_path)
    # scenario "I can get contents from my dropbox account" do

      # @token = ENV['DROPBOX_TOKEN']
      # @client = DropboxApi::Client.new(@token)
      # @theif = DropboxTheif.new(@client, "dbid:AADpQYmD5FJPCJzItJQ8i95Cc-99TcvIgbM")
      #
      # allow_any_instance_of(DropboxController).to receive(:auth_callback).and_return(theif)
      #
      # @auth_code = OAuth2::Client.new(ENV['DROPBOX_KEY'], ENV['DROPBOX_SECRET'], {
      # :authorize_url => 'https://www.dropbox.com/oauth2/authorize',
      # :token_url => 'https://api.dropboxapi.com/oauth2/token'
      # }).auth_code
    #
    #   binding.pry
    #   visit dropbox_auth_callback_path
    #
    #   expect(page).to have_content("Your Dropbox Account Info")
    #   expect(page).to have_content("Your Dropbox Home Folder contents")
    # end
  end
end
