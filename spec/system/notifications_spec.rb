require 'rails_helper'

RSpec.describe 'messages', type: :system do
  let!(:tarou) { create(:user, name: 'tarou', email: 'tarou@test.com') }
  let!(:hanako) { create(:user, name: 'hanako', email: 'hanako@test.com') }

  # tarouがhanakoをフォローする
  it 'フォローしたら通知が作成される', js: true do
    sign_in tarou
    visit user_path(hanako)
    click_button 'フォローする'
    sleep 1
    # hanakoで通知を確認
    sign_out tarou
    sign_in hanako
    visit user_path(hanako)
    click_link 'お知らせ一覧'
    expect(page).to have_content 'tarouさんが あなた をフォローしました'
  end

  describe 'いいねとコメント' do
    let!(:circle) { create(:circle, user: hanako) }
    let!(:blog) { create(:blog, user: hanako, circle: circle) }

    before do
      sign_in tarou
      visit blog_path(blog)
    end

    # tarouがhanakoの投稿にいいねする
    context 'いいね' do
      it 'いいねしたら通知が作成される' do
        click_link '0'
        # hanakoで通知を確認
        sign_out tarou
        sign_in hanako
        visit user_path(hanako)
        click_link 'お知らせ一覧'
        expect(page).to have_content 'tarouさんが あなたの投稿 にいいねしました'
      end
    end

    # tarouがhanakoの投稿にコメントする
    context 'コメント' do
      before do
        fill_in 'コメント内容を記述してください(※100文字以内)', with: 'コメント'
      end

      it 'コメントしたら通知が作成される' do
        click_button '送信'
        # hanakoで通知を確認
        sign_out tarou
        sign_in hanako
        visit user_path(hanako)
        click_link 'お知らせ一覧'
        expect(page).to have_content 'tarouさんが あなたの投稿 にコメントしました'
      end
    end
  end
end
