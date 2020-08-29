require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe '#index' do
    before { get users_path }

    it '正常なレスポンスが返ってくること' do
      expect(response).to have_http_status 200
    end
  end

  # describe '#show' do
  #   before do
  #     sign_in user
  #     get user_path
  #   end

  #   it '正常なレスポンスが返ってくること' do
  #     expect(response).to have_http_status 200
  #   end
  # end

  describe 'POST #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    context '入力値が正しい場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it '新規登録の成功によりユーザーが1人増えること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'リダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context '入力値が不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it 'ユーザー新規登録が失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.not_to change(User, :count)
      end
    end

    context 'メールアドレスが大文字で入力された時' do
      it '大文字から小文字に変換すること' do
        user.email = "TeSt@ExAmPlE.CoM"
        user.save!
        expect(user.email.downcase).to eq user.reload.email
      end
    end
  end

  describe 'edit' do
    context '本人の場合' do
      before do
        sign_in user
        get edit_user_path(user)
      end

      it '正常なレスポンスが返ってくること' do
        expect(response).to have_http_status 200
      end
    end

    context '本人でない場合' do
      before { sign_in user_2 }

      it 'トップページへリダイレクトされること' do
        get edit_user_path(user)
        expect(response).to redirect_to root_path
      end
    end

    # context 'ログインしていない場合' do
    #   before do
    #     get edit_user_path
    #   end

    #   it 'サインイン画面へリダイレクトされること' do
    #     expect(response).to redirect_to new_user_session_path
    #   end
    # end
  end

  # describe '#update' do
  # end
end
