require 'rails_helper'

RSpec.feature 'Visitors can see public binaries without logging in' do
  before do
    @user = create(:user_with_public_folders)
    @user2 = create(:user_with_public_folders)
    @folder1a = @user.owned_folders.second
    @folder1b = @user.owned_folders.last
    @folder2a = @user2.owned_folders.first
    @folder2b = @user2.owned_folders.last
    @binary = @folder1a.binaries.first
  end

  scenario 'Visitor can visit a public binary page from its folders show page' do
    visit root_path
    click_on "Public Folders"
    click_on @folder1a.name

    expect(current_path).to eq(public_folder_path(@folder1a))
    within('h1') do
      expect(page).to have_content(@folder1a.name)
    end
    within('.folder_contents') do
      expect(page).to have_content(@folder1b.name)
      expect(page).to have_content(@binary.name)
    end

    click_on @binary.name

    expect(current_path).to eq(public_folders_binary_path(@binary))
    expect(page).to have_content("File: #{@binary.name}")
  end
end
