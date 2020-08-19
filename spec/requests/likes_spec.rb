require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:circle) { create(:circle, user: user) }
  let!(:blog) { create(:blog, user: user, circle: circle) }

  describe '#create' do
    context 'ログインしている場合' do
      before { sign_in user }

      it '正常にいいね出来ること' do
        expect do
          post blog_likes_path(blog)
        end.to change { blog.likes.count }.by(1)
      end
    end

    context 'ログインしていない場合' do
      before { post blog_likes_path(blog) }

      it 'ログイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    let!(:like) { create(:like, user: user, blog: blog) }

    context 'ログインしている時' do
      context '本人の場合' do
        before { sign_in user }

        it 'いいね解除できること' do
          expect do
            delete blog_like_path(blog, like), params: { like: { user: user } }
          end.to change { blog.likes.count }.by(-1)
        end
      end

      context '本人でない場合' do
        before { sign_in user_2 }

        it 'いいねを解除できないこと' do
          expect { delete blog_like_path(blog, like) }.to change(Like, :count).by(0)
        end
      end
    end

    context 'ログインしていない時' do
      before { delete blog_like_path(blog, like), params: { like: { user: user } } }

      it 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
