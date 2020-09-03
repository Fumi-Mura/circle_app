require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let!(:user) { create(:user) }

  describe 'index' do
    context 'ログインしている時' do
      before do
        sign_in user
        get notifications_path
      end

      it '正常なレスポンスが返ってくること' do
        expect(response).to have_http_status 200
      end
    end

    context 'ログインしていない時' do
      before { get notifications_path }

      it 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
