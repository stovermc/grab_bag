require 'rails_helper'

describe "Users API" do
  it "sends a list of users" do
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
    expect(users.first).to_not have_key("password_diget")
  end
  
  it "sends a list of users" do
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
    expect(users.first).to_not have_key("password_diget")
  end
end
