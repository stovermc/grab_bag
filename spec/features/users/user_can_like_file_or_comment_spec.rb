require 'rails_helper'

RSpec.feature 'A user can like things' do
  attr_reader :user
  before(:each) do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  context 'when she sees a file' do
    scenario 'she can like it and remove like' do
      folder = user.home
      binary = create(:text_binary, folder: folder)

      visit folder.url
      click_on binary.name

      expect(current_path).to eq(binary.url)
      expect(page).to have_content("File Likes: 0")
      click_on("Like File")

      expect(current_path).to eq(binary.url)
      expect(page).to have_content("File Likes: 1")
      click_on("Unlike File")
      expect(page).to have_content("File Likes: 0")
    end
  end

  context 'when she sees a comment' do
    scenario 'she can like it and remove like' do
      folder = user.home
      binary = create(:text_binary, folder: folder)

      visit folder.url
      click_on binary.name

      fill_in "comment[text]", with: "This is a comment."
      click_on('Post Comment')

      click_on("Like Comment")

      expect(current_path).to eq(binary.url)
      expect(page).to have_content("Comment Likes: 1")
      
      click_on("Unlike Comment")
      expect(page).to have_content("Comment Likes: 0")
    end
  end
end
