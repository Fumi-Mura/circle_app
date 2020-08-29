require 'rails_helper'

RSpec.describe 'messages', type: :system do
  let!(:tarou) { create(:user, name: 'tarou', email: 'tarou@test.com') }
  let!(:hanako) { create(:user, name: 'hanako', email: 'hanako@test.com') }

  it 'DMを送信する', js: true do
    # hanakoとのメッセージルームを作成する
    sign_in tarou
    visit user_path(hanako)
    expect(page).to have_content 'hanako'
    click_button 'メッセージ'
    expect(page).to have_content 'hanakoさんとの会話'
    expect(page).not_to have_content 'tarou'

    # tarouからhanakoにメッセージを送信する
    fill_in 'メッセージを入力してください', with: 'hanakoさん、こんにちは'
    click_button '送 信'
    expect(page).to have_content 'hanakoさん、こんにちは'
    expect(page).to have_content 'tarou'

    # userをtarouからhanakoに切り替える
    sign_out tarou
    sign_in hanako

    # tarouとのメッセージルームに移動し、メッセージが受信できているか確認する
    visit user_path(tarou)
    expect(page).to have_content 'tarou'
    click_button 'メッセージ'
    expect(page).to have_content 'tarouさんとの会話'
    expect(page).to have_content 'hanakoさん、こんにちは'

    # hanakoからtarouにメッセージを送信する
    fill_in 'メッセージを入力してください', with: 'tarouさん、こんにちは'
    click_button '送 信'
    expect(page).to have_content 'tarouさん、こんにちは'

    # userをhanakoからtarouに切り替える
    sign_out hanako
    sign_in tarou

    # tarouとのメッセージルームに移動し、メッセージが受信できているか確認する
    visit user_path(hanako)
    expect(page).to have_content 'hanako'
    click_button 'メッセージ'
    expect(page).to have_content 'hanakoさんとの会話'
    expect(page).to have_content 'tarouさん、こんにちは'
  end

  it 'DM一覧ページを表示する', js: true do
    sign_in tarou
    visit user_path(hanako)
    click_button 'メッセージ'
    fill_in 'メッセージを入力してください', with: 'hanakoさん、こんにちは'
    click_button '送 信'
    visit rooms_path(tarou)
    expect(page).to have_content 'hanakoさんとの会話'
  end
end
