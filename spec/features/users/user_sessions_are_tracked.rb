require 'rails_helper'

RSpec.feature "A user logs in and session is tracked" do
  before do
    user = create :regular_user
    visit '/'
    fill_in 'user[username]', with: user.username
    fill_in 'user[password]', with: 'banana'
    click_on 'Log In with Grab Bag' 
  end

  it 'can track log-on time' do
    expect(SessionStat.last.log_in_day).to eq(Time.now.strftime('%A'))
  end
  
  it 'can track duration of a session' do
    sleep(3)
    click_link "Logout"
    expect(((SessionStat.last.duration)/10).round).to eq(((Time.now - (Time.now + 185))/10).round)
  end
  
end