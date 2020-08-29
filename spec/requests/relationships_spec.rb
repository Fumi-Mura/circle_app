require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }

  describe 'index' do
    context 'ログインしている時' do
      before { sign_in user }

      context 'フォロワー一覧ページへアクセスする場合' do
        before { get followers_user_path(user) }

        it '正常なレスポンスが返ってくること' do
          expect(response).to have_http_status 200
        end
      end

      context 'フォロー一覧ページへアクセスする場合' do
        before { get following_user_path(user) }

        it '正常なレスポンスが返ってくること' do
          expect(response).to have_http_status 200
        end
      end
    end

    context 'ログインしていない時' do
      context 'フォロワー一覧ページへアクセスする場合' do
        before { get followers_user_path(user) }

        it 'サインイン画面へリダイレクトされること' do
          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'フォロー一覧ページへアクセスする場合' do
        before { get following_user_path(user) }

        it 'サインイン画面へリダイレクトされること' do
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe '#create' do
    context 'ログインしている時' do
      before { sign_in user }

      # context 'フォローしていない場合' do
      #   it 'フォローできること' do
      #     expect do
      #       post relationships_path(user_2), params: { user: user_2 }, xhr: true
      #     end.to change { user.following.count }.by(1)
      #   end
      # end

      context '既にフォローしている場合' do
        before { user.follow user_2 }

        it 'フォローできないこと' do
          expect do
            post relationships_path(user_2), params: { user: user_2 }, xhr: true
          end.to change { user.following.count }.by(0)
        end
      end
    end

    # context 'ログインしていない時' do
    #   before { post relationships_path(user_2), params: { user: user_2 } }

    #   it 'サインイン画面へリダイレクトされること' do
    #     expect(response).to redirect_to new_user_session_path
    #   end
    # end
  end

  describe '#destroy' do
    context 'ログインしている時' do
      before { sign_in user }

      # context 'フォローしている場合' do
      #   before { user.follow user_2 }

      #   it 'フォロー解除できること' do
      #     expect do
      #       delete relationship_path(user_2), params: { user: user_2 }, xhr: true
      #     end.to change { user.following.count }.by(-1)
      #   end
      # end

      context 'フォローしていない場合' do
        it 'フォロー解除できないこと' do
          expect do
            delete relationship_path(user_2), params: { user: user_2 }, xhr: true
          end.to change { user.following.count }.by(0)
        end
      end
    end

    context 'ログインしていない時' do
      before { delete relationship_path(user_2), params: { user: user_2 } }

      it 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
