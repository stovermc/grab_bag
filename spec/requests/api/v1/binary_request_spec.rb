require 'rails_helper'

describe "Binaries API" do
  it "can find the amount of binaries by file type" do
    create :user_with_various_binary_types

    get '/api/v1/binaries_by_type'

    expect(response).to be_success

    binaries = JSON.parse(response.body)

    expect(binaries.first).to have_key("File Type")
    expect(binaries.first).to have_key("Total")

    expect(binaries.first['File Type']).to eq("txt")
    expect(binaries.first['Total']).to eq(1)
    expect(binaries.second['File Type']).to eq("jpg")
    expect(binaries.second['Total']).to eq(1)
    expect(binaries.third['File Type']).to eq("png")
    expect(binaries.third['Total']).to eq(1)
    expect(binaries.last['File Type']).to eq("pdf")
    expect(binaries.last['Total']).to eq(1)
  end
end
