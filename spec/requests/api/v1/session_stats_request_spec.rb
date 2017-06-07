require 'rails_helper'

describe "SessionStats API" do
  xit "provides number of users logged in per day of the week" do
    3.times {login(user)}

    get '/api/v1/log_ins_by_weekday'

    expect(response).to be_success

    logins = JSON.parse(response.body)
    
    expect(logins.first).to have_key("Weekday")
    expect(logins.first).to have_key("Average Number of Logins")
    expect(logins.first["Weekday"]).to eq(Time.now.to_date.strftime("%A"))
    expect(logins.first["Average Number of Logins"]).to eq(3)
  end
end