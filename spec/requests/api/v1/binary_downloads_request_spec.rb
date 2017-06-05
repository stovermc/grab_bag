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
end
