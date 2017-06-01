require 'rails_helper'

RSpec.feature 'Visitors can see all public folders' do
  before do
    # require "pry"; binding.pry
    @user = create(:user_with_public_folders)
    @user2 = create(:user_with_public_folders)
    @folder1a = @user.owned_folders.second
    @folder1b = @user.owned_folders.last

    # @folder1a = @folder1.folders.create(:folder)
    #
    # @binary1a = @folder1.binaries.create(:binary)

    @folder2a = @user2.owned_folders.first
    @folder2b = @user2.owned_folders.last


  end
  scenario 'Visitor visits root path' do
    visit landing_page_path
    click_on "Public Folders"

    expect(current_path).to eq(public_folders_path)
    expect(page).to have_css('tr', count: 2)

    within(".table") do
      expect(page).to have_content(@folder1a.name)
    end
  end


  scenario 'Visitor visits a public folder show page' do
    visit landing_page_path
    click_on "Public Folders"

    click_on @folder1a.name

    expect(current_path).to eq(public_folder_path(@folder1a))
    within('h1') do
      expect(page).to have_content(@folder1a.name)
    end
    within('.folder_contents') do
      expect(page).to have_content(@folder1b.name)
      expect(page).to have_content(@folder1a.binaries.first.name)
    end

  end
end
