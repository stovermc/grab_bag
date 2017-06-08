require 'rails_helper'

describe Uploader do

  before :each do
    @user = create(:user)
    @params = { file_name: "file.txt", path: "/file.txt"}
    @token = ENV['DROPBOX_TOKEN']
    @client = DropboxApi::Client.new(@token)
    @uploader = Uploader.new(@client, @params, @user)
    @s3_object = Aws::S3::Object.new(bucket_name="1701grabbag", key="uploads/4459e3d6-f8ff-44bf-b129-b52f1d5da02b/more_words.txt")
  end

  it "#broken_name" do
    name = @uploader.broken_name

    expect(name).to be_an(Array)
    expect(name[0]).to eq('file')
    expect(name[1]).to eq('txt')
  end

  it "#home_folder" do
    home_folder = @uploader.home_folder

    expect(home_folder.name).to eq('home')
    expect(home_folder.route).to eq('home')
    expect(home_folder.slug).to eq('home')
    expect(home_folder.user_id).to eq(@user.id)
  end

  it "#upload_to_grabbag" do
    new_file = @uploader.upload_to_grabbag(@s3_object)

    expect(new_file).to be_a(Binary)
    expect(new_file.folder.name).to eq('home')
    expect(new_file.name).to eq('file')
    expect(new_file.extension).to eq('txt')
    expect(new_file.data_url).to eq("https://1701grabbag.s3-us-west-1.amazonaws.com/uploads/4459e3d6-f8ff-44bf-b129-b52f1d5da02b/more_words.txt")
  end
end
