require 'rails_helper'

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:circle) { create(:circle, user: user) }
  let!(:blog) { create(:blog, user: user, circle: circle) }
  let(:comment) { create(:comment, blog: blog) }

  describe '#create' do
    context 'ログインしている場合' do
      before { sign_in user }

      it '正常に作成できること' do
        expect do
          post comments_path, params: { post: comment }
        end.to change { blog.comments.count }.by(1)
      end
    end

    context 'ログインしていない場合' do
      before { post comments_path, params: { post: comment } }

      it 'ログインページにリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    let!(:comment) { create(:comment, blog: blog) }

    context '本人の場合' do
      before { sign_in user }

      it '正常に削除できること' do
        expect do
          delete comment_path(comment)
        end.to change { blog.comments.count }.by(-1)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        delete comment_path(comment)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
