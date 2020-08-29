require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  let!(:tarou) { create(:user, name: 'tarou', email: 'tarou@test.com') }
  let!(:hanako) { create(:user, name: 'hanako') }

  it 'ユーザーをフォロー/フォロー解除する', js: true do
    # tarouがログインする
    sign_in tarou

    # hanakoをフォローする
    visit user_path(hanako)
    expect(page).to have_content 'hanako'
    expect(page).to have_content '0 フォロワー'
    expect do
      click_button 'フォローする'
      expect(page).to have_content '1 フォロワー'
      expect(page).not_to have_content '0 フォロワー'
    end.to change(tarou.following, :count).by(1) &
          change(hanako.followers, :count).by(1)

    # マイページ(tarou)に移動し、hanakoが追加されているか確認
    visit user_path(tarou)
    expect(current_path).to eq "/users/#{tarou.id}"
    expect(page).to have_content 'tarou'
    click_link 'フォロー中'
    expect(current_path).to eq "/users/#{tarou.id}/following"
    expect(page).to have_content 'hanako'

    # hanakoのフォローを解除する
    click_link 'hanako'
    expect do
      click_button 'フォロー外す'
      expect(page).to have_content '0 フォロー'
      expect(page).not_to have_content '1 フォロー'
    end.to change(tarou.following, :count).by(-1) &
          change(hanako.followers, :count).by(-1)

    # マイページ(tarou)に移動し、hanakoが削除されているか確認
    visit user_path(tarou)
    click_link 'フォロー中'
    expect(current_path).to eq "/users/#{tarou.id}/following"
    expect(page).not_to have_content 'hanako'
  end
end
