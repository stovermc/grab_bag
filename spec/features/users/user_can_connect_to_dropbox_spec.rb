require 'rails_helper'

RSpec.feature "User can connect to dropbox" do
  context "As a logged in User who also has a dropbox account" do

    attr_reader :user

    before :each do
      @user = create(:user)
    end

    scenario "I can connect to my dropbox account" do

      click_on 'Connect to Dropbox'

      expect(current_path).to eq()
      expect(page).to have_content #(your dropbox stuff...)
    end
  end
end
