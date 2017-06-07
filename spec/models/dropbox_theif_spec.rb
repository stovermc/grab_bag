require 'rails_helper'


describe DropboxTheif do

  before :each do
    @token = ENV['DROPBOX_TOKEN']
    @client = DropboxApi::Client.new(@token)
    @dropbox_theif = DropboxTheif.new(@client, "dbid:AADpQYmD5FJPCJzItJQ8i95Cc-99TcvIgbM")
  end

  it " #account_info" do
    account = @dropbox_theif.account_info

    expect(account).to be_a(DropboxApi::Metadata::BasicAccount)
    expect(account.email).to eq('stephanielague@gmail.com')
  end

  it " #space_allocated" do
    space = @dropbox_theif.space_allocated

    expect(space).to eq(2.6)
  end

  it "#space_used" do
    space = @dropbox_theif.space_used

    expect(space).to eq(1.62)
  end

  it "#home_folder_contents" do
    home_folders = @dropbox_theif.home_folder_contents

    expect(home_folders).to be_an(Array)
    expect(home_folders[0]).to be_a(DropboxApi::Metadata::Folder)
    expect(home_folders[0].name).to eq("Photos")
    expect(home_folders[0].path_display).to eq("/Photos")
  end

end
