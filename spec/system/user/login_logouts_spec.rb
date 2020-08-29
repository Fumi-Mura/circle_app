require 'rails_helper'

RSpec.describe 'sign_ups', type: :system do
  let!(:tarou) { create(:user, name: 'tarou', email: 'tarou@test.com') }

  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'tarou@test.com'
    fill_in 'パスワード', with: 'password'
  end

  describe '入力が正しい場合' do
    it '正常にログインできること', js: true do
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content '次回から自動的にログイン'
      click_button 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログインしました'
    end
  end

  describe '入力が正しくない場合' do
    context 'メールアドレスが正しくない時' do
      it 'ログインできないこと', js: true do
        fill_in 'メールアドレス', with: 'not_tarou@test.com'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です'
      end
    end

    context 'パスワードが正しくない時' do
      it 'ログインできないこと', js: true do
        fill_in 'パスワード', with: 'not_password'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です'
      end
    end
  end

  describe 'ゲストユーザーでログインする場合' do
    it 'ゲストユーザーとしてログインできること' do
      click_link 'ゲストユーザーでログイン'
      expect(page).to have_content 'ゲストユーザーとしてログインしました'
    end
  end
end
