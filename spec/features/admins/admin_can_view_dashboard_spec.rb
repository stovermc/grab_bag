require 'rails_helper'
require 'helpers/admin_helper'

RSpec.feature "Admin can see analytics dashboard" do
  context "As a logged-in Admin" do

    before :each do
      stub_admin
    end

    xscenario "Admin can visit admin_dashboard and see a basic chart total users based on account creation date" do
      create_list(:user, 3)
      create(:user, created_at: Date.yesterday)
      
      visit admin_dashboard_path
      
      within ".users_created_at_chart" do
        expect(page).to have_content("#{Date.today}: 3")
        expect(page).to have_content("#{Date.yesterday}: 1")
        # expect(page).to have_chart
      end
    end
    
  end
end