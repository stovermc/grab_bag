require 'rails_helper'

describe "Session Stats API" do
  it "provides number of users logged in by day of the week" do
    SessionStat.create(log_in_day: "Wednesday")
    SessionStat.create(log_in_day: "Wednesday")
    SessionStat.create(log_in_day: "Sunday")

    get '/api/v1/log_ins_by_weekday'

    expect(response).to be_success

    logins = JSON.parse(response.body)
    
    expect(logins.first).to have_key("Weekday")
    expect(logins.first).to have_key("Number of Logins")
    expect(logins.first["Weekday"]).to eq("Wednesday")
    expect(logins.first["Number of Logins"]).to eq(2)
    expect(logins.second["Weekday"]).to eq("Sunday")
    expect(logins.second["Number of Logins"]).to eq(1)
  end
end