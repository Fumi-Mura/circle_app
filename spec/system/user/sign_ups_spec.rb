require 'rails_helper'

RSpec.describe 'sign_ups', type: :system do
  before do
    visit new_user_registration_path
    fill_in '名前', with: 'tarou'
    fill_in 'メールアドレス', with: 'tarou@test.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード確認用', with: 'password'
  end

  describe '入力が正しい場合' do
    it '正常に登録できること' do
      click_button '新規登録'
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end

  describe '入力が正しくない場合' do
    context '名前が空欄の時' do
      it '登録失敗のメッセージが表示されること' do
        fill_in '名前', with: ''
        click_button '新規登録'
        expect(page).to have_content '名前を入力してください'
      end
    end

    context '名前が文字数オーバーの時' do
      it '登録失敗のメッセージが表示されること' do
        fill_in '名前', with: 'a' * 31
        click_button '新規登録'
        expect(page).to have_content '名前は30文字以内で入力してください'
      end
    end

    context 'メールアドレスが空欄の時' do
      it '登録失敗のメッセージが表示されること' do
        fill_in 'メールアドレス', with: ''
        click_button '新規登録'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end

    context 'メールアドレスが文字数オーバーの時' do
      it '登録失敗のメッセージが表示されること' do
        fill_in 'メールアドレス', with: 'a' * 256 + '@example.com'
        click_button '新規登録'
        expect(page).to have_content 'メールアドレスは256文字以内で入力してください'
      end
    end

    context 'メールアドレスが重複している場合' do
      before { create(:user, email: 'tarou@test.com') }

      it '登録失敗のメッセージが表示されること' do
        click_button '新規登録'
        expect(page).to have_content 'メールアドレスはすでに存在します'
      end
    end

    context 'パスワードが空欄の時' do
      it '登録失敗のメッセージが表示されること' do
        fill_in 'パスワード', with: ''
        click_button '新規登録'
        expect(page).to have_content 'パスワードを入力してください'
      end
    end

    context 'パスワード文字数が少ない場合' do
      it '登録失敗のメッセージが表示されること' do
        fill_in 'パスワード', with: 'a' * 5
        fill_in 'パスワード確認用', with: 'a' * 5
        click_button '新規登録'
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end

    context 'パスワードが確認用と異なる場合' do
      it '登録失敗のメッセージが表示されること' do
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認用', with: 'abcdefgh'
        click_button '新規登録'
        expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
      end
    end
  end
end
