require 'rails_helper'

describe "Users API" do
  it "provides users and associated attributes" do
    2.times do |n|
      User.create!(name: "name#{n}",
                  username: "username#{n}",
                  email: "email#{n}@grabbag.com",
                  phone: '5555555555',
                  status: 'active',
                  password: 'banana',
                  avatar_url: "https://robohash.org/#{n}")
    end

    get '/api/v1/users'

    expect(response).to be_success

    users = JSON.parse(response.body)

    expect(users.count).to eq(2)
    expect(users.first).to have_key("name")
    expect(users.first).to have_key("username")
    expect(users.first).to have_key("email")
    expect(users.first).to have_key("phone")
    expect(users.first).to_not have_key("password")
    expect(users.first).to_not have_key("password_digest")
  end

  it "provides accumulated users by month" do
    create_list(:user, 5)
    User.first.update(created_at: Time.now.to_date - 64)
    User.second.update(created_at: Time.now.to_date - 32)

    get '/api/v1/accumulated_users_by_month'

    expect(response).to be_success

    users_by_months = JSON.parse(response.body)

    expect(users_by_months.count).to eq(3)
    expect(users_by_months.first).to have_key("Month")
    expect(users_by_months.first).to have_key("Total Number of Users")
    expect(users_by_months.first["Month"]).to eq((Time.now.to_date - 64).strftime("%b %Y"))
    expect(users_by_months.first["Total Number of Users"]).to eq(1)
    expect(users_by_months.second["Month"]).to eq((Time.now.to_date - 32).strftime("%b %Y"))
    expect(users_by_months.second["Total Number of Users"]).to eq(2)
    expect(users_by_months.third["Month"]).to eq((Time.now.to_date).strftime("%b %Y"))
    expect(users_by_months.third["Total Number of Users"]).to eq(5)
  end
end
