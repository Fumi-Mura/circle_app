require 'rails_helper'

RSpec.describe 'comments', type: :system do
  let!(:tarou) { create(:user, name: 'tarou', email: 'tarou@test.com') }
  let!(:hanako) { create(:user, name: 'hanako', email: 'hanako@test.com') }
  let!(:circle) { create(:circle, user: tarou) }
  let!(:blog) { create(:blog, user: tarou, circle: circle) }

  describe 'create' do
    context 'ログインしている場合' do
      before do
        sign_in tarou
        visit blog_path(blog)
      end

      context '入力値が正しい場合' do
        it '正常に作成できること' do
          fill_in 'コメントが送れます', with: 'tarou comment comment'
          click_button '送信'
          expect(page).to have_content 'コメントを投稿しました'
          expect(page).to have_content '@tarou'
          expect(page).to have_content 'tarou comment comment'
        end
      end

      context '入力値が正しくない場合' do
        it 'commentが空だと作成できないこと' do
          fill_in 'コメントが送れます', with: ''
          click_button '送信'
          expect(page).to have_content 'コメントを入力してください'
        end

        it 'contentが101文字以上だと作成できないこと' do
          fill_in 'コメントが送れます', with: 'a' * 101
          click_button '送信'
          expect(page).to have_content 'コメントは100文字以内で入力してください'
        end
      end
    end
  end

  describe 'destroy' do
    context '本人の場合' do
      before do
        sign_in hanako
        visit blog_path(blog)
      end

      it '正常に削除できること' do
        fill_in 'コメントが送れます', with: 'hanako comment comment'
        click_button '送信'
        click_link '削除'
        expect(page).to have_content 'コメントを削除しました'
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
