require 'rails_helper'

RSpec.feature 'Visitors not logged in cannot like comments or binaries' do
  before do
    @comment = create(:comment)
    @binary = @comment.binary
  end

  scenario 'Visitor can view binaries, but must log in to like or add comments' do
    visit public_folders_binary_path(@binary)

    click_on "Like Comment"

    expect(current_path).to eq(public_folders_binary_path(@binary))

    within('.alert') do
      expect(page).to have_content('Log in to add comments and likes.')
    end

  end
end
