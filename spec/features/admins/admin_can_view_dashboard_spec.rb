require 'rails_helper'
require 'helpers/admin_helper'

RSpec.feature "Admin can see analytics dashboard" do
  context "As a logged-in Admin" do

    before :each do
      stub_admin
    end

    scenario "Admin can visit admin_dashboard analytics" do
      create_list(:user, 3)
      create(:user, created_at: Date.yesterday)
      
      visit admin_dashboard_path
      
      end
    end
    
  end
end