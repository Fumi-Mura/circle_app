require 'rails_helper'

RSpec.describe 'circles', type: :system do
  let!(:tarou) { create(:user, name: 'tarou', email: 'tarou@test.com') }
  let!(:hanako) { create(:user, name: 'hanako', email: 'hanako@test.com') }

  describe 'create' do
    context '入力値が正しい場合' do
      it '正常に作成できること' do
        sign_in tarou
        visit new_circle_path
        fill_in 'サークルの名前', with: 'tarou circle name'
        fill_in '活動内容', with: 'tarou circle content'
        click_button '登録する'
        expect(page).to have_content 'tarou circle nameを作成しました'
        expect(page).to have_content 'tarou さんがこのサークルを作成しました'
      end
    end

    context '入力値が正しくない場合' do
      before do
        sign_in tarou
        visit new_circle_path
      end

      it 'nameが空だと作成できないこと' do
        fill_in 'サークルの名前', with: ''
        fill_in '活動内容', with: 'tarou circle content'
        click_button '登録する'
        expect(page).to have_content 'サークル名を入力してください'
      end

      it 'contentが空だと作成できないこと' do
        fill_in 'サークルの名前', with: 'tarou circle name'
        fill_in '活動内容', with: ''
        click_button '登録する'
        expect(page).to have_content '活動内容を入力してください'
      end

      it 'nameが31文字以上だと作成できないこと' do
        fill_in 'サークルの名前', with: 'a' * 31
        fill_in '活動内容', with: 'tarou circle content'
        click_button '登録する'
        expect(page).to have_content 'サークル名は30文字以内で入力してください'
      end

      it 'contentが1001文字以上だと作成できないこと' do
        fill_in 'サークルの名前', with: 'tarou circle name'
        fill_in '活動内容', with: 'a' * 1001
        click_button '登録する'
        expect(page).to have_content '活動内容は1000文字以内で入力してください'
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトされること' do
        visit new_circle_path
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'update' do
    let(:circle) { create(:circle, user: tarou) }

    context '本人の場合' do
      before do
        sign_in tarou
        visit circle_path(circle)
      end

      it '正常に編集画面に遷移できること' do
        click_link '編集'
        expect(page).to have_content 'サークルの名前'
      end

      it '正常に更新できること' do
        click_link '編集'
        fill_in 'サークルの名前', with: 'change cirlce name'
        fill_in '活動内容', with: 'change circle content'
        click_button '更新する'
        expect(page).to have_content 'change cirlce nameの情報を更新しました'
        expect(page).to have_content 'change circle content'
      end

      it '名前、活動内容が空だと更新に失敗すること' do
        click_link '編集'
        fill_in 'サークルの名前', with: ''
        fill_in '活動内容', with: ''
        click_button '更新する'
        expect(page).to have_content 'サークル名を入力してください'
        expect(page).to have_content '活動内容を入力してください'
      end
    end

    context '本人以外の場合' do
      before do
        sign_in hanako
        visit circle_path(circle)
      end

      it '編集ボタンが表示されないこと' do
        expect(page).not_to have_content '編集'
      end
    end
  end

  describe 'destroy' do
    let(:circle) { create(:circle, user: tarou) }

    context '本人の場合' do
      before do
        sign_in tarou
        visit circle_path(circle)
      end

      it '正常に削除でき、サークル一覧画面へリダイレクトされること' do
        click_link '削除'
        expect(page).to have_content 'サークルを削除しました'
        expect(current_path).to eq '/circles'
      end
    end

    context '本人以外の場合' do
      before do
        sign_in hanako
        visit circle_path(circle)
      end

      it '削除ボタンが表示されないこと' do
        expect(page).not_to have_content '削除'
      end
    end
  end
end
