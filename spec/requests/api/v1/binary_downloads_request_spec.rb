require 'rails_helper'

describe "Users API" do
  it "sends a list of binary_downloads" do
    user = create :user_with_folders
    binaries = user.home.binaries

    BinaryDownload.create!(user: user, binary: binaries.first, created_at: '11/12/2016')
    BinaryDownload.create!(user: user, binary: binaries.second, created_at: '15/12/2016')

    get '/api/v1/binary_downloads'

    expect(response).to be_success

    binary_downloads = JSON.parse(response.body)

    expect(binary_downloads.count).to eq(2)
    expect(binary_downloads.first).to have_key("user_id")
    expect(binary_downloads.first).to have_key("binary_id")
    expect(binary_downloads.first).to have_key("created_at")
    expect(binary_downloads.first['created_at']).to eq("2016-12-11T00:00:00.000Z")
  end

  it "sends a list of accumulated downloads by date" do
    user = create :user_with_folders
    binaries = user.home.binaries

    BinaryDownload.create!(user: user, binary: binaries.first, created_at: '11/12/2016')
    BinaryDownload.create!(user: user, binary: binaries.second, created_at: '15/12/2016')

    get '/api/v1/binary_downloads_by_date'

    expect(response).to be_success

    binary_downloads = JSON.parse(response.body)

    expect(binary_downloads.count).to eq(2)
    expect(binary_downloads.first).to have_key("date")
    expect(binary_downloads.first).to have_key("accumulated_downloads")

    expect(binary_downloads.first['date']).to eq("2016-12-11")
    expect(binary_downloads.first['accumulated_downloads']).to eq(1)
  end

  it "can find the amount of public and private binary downloads" do
    user = create :user_with_folders
    user2 = create :user_with_public_folders
    binaries = user.home.binaries
    folder = user2.home.folders.first.folders.second
    binary = folder.binaries.create!(name: "binary", extension: ".txt", data_url: 'http://textfiles.com/100/914bbs.txt')

    BinaryDownload.create!(user: user, binary: binaries.first)
    BinaryDownload.create!(user: user, binary: binaries.second)
    BinaryDownload.create!(user: user2, binary: folder.binaries.first)
    BinaryDownload.create!(user: user, binary: folder.binaries.first)
    BinaryDownload.create!(user: user, binary: binary)

    get '/api/v1/binary_downloads_public_v_private'

    expect(response).to be_success

    binary_downloads = JSON.parse(response.body)

    expect(binary_downloads.count).to eq(5)
    expect(binary_downloads.first).to have_key("permission")
    expect(binary_downloads.first).to have_key("downloads")

    expect(binary_downloads.first['permission']).to eq("public")
    expect(binary_downloads.first['downloads']).to eq(3)
    expect(binary_downloads.second['permission']).to eq("private")
    expect(binary_downloads.second['downloads']).to eq(2)
    # [{Permission: 'Public', Downloads: 3}, {Permission: 'Private', Downloads: 2}]

  end
end
