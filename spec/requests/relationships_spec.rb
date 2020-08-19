require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }

  # describe '#create' do
  #   context 'ログインしている時' do
  #     before { sign_in user }
  #     context 'フォローしていない場合' do
  #       it 'フォローできること' do
  #         expect do
  #           post relationships_path(user_2), params: { user: user_2 }, xhr: true
  #         end.to change { user.following.count }.by(1)
  #       end
  #     end
  #     context '既にフォローしている場合' do
  #       before { user.follow user_2 }
  #       it 'フォローできないこと' do
  #         expect do
  #           post relationships_path(user_2), params: { user: user_2 }, xhr: true
  #         end.to change { user.following.count }.by(0)
  #       end
  #     end
  #   end
  #   context 'ログインしていない時' do
  #     before { post relationships_path(user_2), params: { user: user_2 } }
  #     it 'サインイン画面へリダイレクトされること' do
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end
end
