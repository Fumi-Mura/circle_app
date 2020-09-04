require 'rails_helper'

RSpec.describe 'blogs', type: :system do
  let!(:tarou) { create(:user, name: 'tarou', email: 'tarou@test.com') }
  let!(:hanako) { create(:user, name: 'hanako', email: 'hanako@test.com') }
  let!(:circle) { create(:circle, user: tarou) }

  describe 'create' do
    context 'サークル作成者の場合' do
      before do
        sign_in tarou
        visit circle_path(circle)
      end

      context '入力値が正しい場合' do
        it '正常に作成できること' do
          fill_in 'ブログのタイトル', with: 'tarou blog name'
          fill_in 'ブログの内容', with: 'tarou blog content'
          click_button '投稿する'
          expect(page).to have_content 'tarou blog nameを投稿しました'
          expect(page).to have_content 'tarou さんがこのブログを作成しました'
        end
      end

      context '入力値が正しくない場合' do
        it 'nameが空だと作成できないこと' do
          fill_in 'ブログのタイトル', with: ''
          fill_in 'ブログの内容', with: 'tarou blog content'
          click_button '投稿する'
          expect(page).to have_content 'タイトルを入力してください'
        end

        it 'contentが空だと作成できないこと' do
          fill_in 'ブログのタイトル', with: 'tarou blog name'
          fill_in 'ブログの内容', with: ''
          click_button '投稿する'
          expect(page).to have_content '投稿内容を入力してください'
        end

        it 'nameが31文字以上だと作成できないこと' do
          fill_in 'ブログのタイトル', with: 'a' * 51
          fill_in 'ブログの内容', with: 'tarou blog content'
          click_button '投稿する'
          expect(page).to have_content 'タイトルは50文字以内で入力してください'
        end

        it 'contentが1001文字以上だと作成できないこと' do
          fill_in 'ブログのタイトル', with: 'tarou blog name'
          fill_in 'ブログの内容', with: 'a' * 1001
          click_button '投稿する'
          expect(page).to have_content '投稿内容は1000文字以内で入力してください'
        end
      end
    end

    context '本人以外の場合' do
      it '投稿フォームが表示されないこと' do
        sign_in hanako
        visit circle_path(circle)
        expect(page).not_to have_content '投稿する'
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページへリダイレクトされること' do
        visit new_blog_path
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe 'update' do
    let(:blog) { create(:blog, user: tarou) }

    context '本人の場合' do
      before do
        sign_in tarou
        visit blog_path(blog)
      end

      it '正常に編集画面に遷移できること' do
        click_link '編集'
        expect(page).to have_content '活動実績を投稿しよう！'
      end

      it '正常に更新できること' do
        click_link '編集'
        fill_in 'ブログのタイトル', with: 'change blog name'
        fill_in 'ブログの内容', with: 'change blog content'
        click_button '投稿する'
        expect(page).to have_content 'change blog nameを更新しました'
        expect(page).to have_content 'change blog content'
      end

      it 'タイトル、投稿内容が空だと更新に失敗すること' do
        click_link '編集'
        fill_in 'ブログのタイトル', with: ''
        fill_in 'ブログの内容', with: ''
        click_button '投稿する'
        expect(page).to have_content 'タイトルを入力してください'
        expect(page).to have_content '投稿内容を入力してください'
      end
    end

    context '本人以外の場合' do
      before do
        sign_in hanako
        visit blog_path(blog)
      end

      it '編集ボタンが表示されないこと' do
        expect(page).not_to have_content '編集'
      end
    end
  end

  describe 'destroy' do
    let(:blog) { create(:blog, user: tarou) }

    context '本人の場合' do
      before do
        sign_in tarou
        visit blog_path(blog)
      end

      it '正常に削除できること' do
        click_link '削除'
        expect(page).to have_content 'test_blog_titleブログを削除しました'
      end
    end

    context '本人以外の場合' do
      before do
        sign_in hanako
        visit blog_path(blog)
      end

      it '削除ボタンが表示されないこと' do
        expect(page).not_to have_content '削除'
      end
    end
  end
end
