module LoginMacros
  def login(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
  end

  def logout(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    visit root_path
    click_link 'ログアウト'
    expect(page).to have_content 'ログアウトしました。'
  end
end
