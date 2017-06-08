module LoginHelper

  def login(user)
    user = create :regular_user
    visit '/'
    fill_in 'user[username]', with: user.username
    fill_in 'user[password]', with: 'banana'
    click_on 'Log In with Grab Bag' 
  end

  def logout
    click_link 'Logout'
  end

end