require 'rails_helper'

RSpec.feature "User can connect to dropbox" do
  context "As a logged in User who also has a dropbox account" do

    attr_reader :user

    before :each do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      #mock_auth
    end

    scenario "I can connect to my dropbox account" do

      visit user.home.url
      click_on 'Connect to Dropbox'

#mock starts here... gives a fake login
      # expect(current_path).to eq('/oauth2/authorize')

save_and_open_page
      # omniauth mock_auth
      #click_on 'Allow'

      # expect(current_path).to eq(dropbox_auth_callback_path)

    end
    xscenario "I can get contents from my dropbox account" do

      #stub calls to get files and folders
      #allow any instance of... to receive ...
      #check dropbox_api gem

      visit dropbox_auth_callback_path

      expect(page).to have_content("Your Dropbox Account Info")
      expect(page).to have_content("Your Dropbox Home Folder contents")
    end
  end
end
