require 'rails_helper'

describe "Users API" do
  it "sends a list of folders" do
    user = create(:user_with_folders)
    allow_any_instance_of(FoldersController).to receive(:current_user).and_return(user)

    get '/api/v1/sharing/list_folders'

    expect(response).to be_success

    folders = JSON.parse(response.body)
    binding.pry

    expect(folders.count).to eq(2)
    expect(folders.first).to have_key("name")
    expect(folders.first).to have_key("username")
    expect(folders.first).to have_key("email")
    expect(folders.first).to have_key("phone")
    expect(folders.first).to_not have_key("password")
  end
end
