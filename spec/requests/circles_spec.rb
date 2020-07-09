require 'rails_helper'

RSpec.describe 'Circles', type: :request do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let(:circle) { create(:circle, user: user) }
  let!(:circle_2) { create(:circle, content: "circle_2") }
  
  # describe '#index' do
  #   before { get circles_path }
  #   it '正常なレスポンスが返ってくること' do
  #     expect(response).to have_http_status(200)
  #   end
  # end
  
  describe "#show" do
    before { get circle_path(circle) }
    it '正常なレスポンスが返ってくること' do
      expect(response).to have_http_status(302)
    end
  end
  
  describe '#new' do
    it '正常なレスポンスが返ってくること' do
      get new_circle_path
      sign_in user
      expect(response).to have_http_status 302
    end
  end
  
  describe 'create' do
    context 'ログインしている場合' do
      before { sign_in user }
      it '正常に作成できること' do
        expect do
          post circles_path, params: { post: circle }
        end.to change{ user.circles.count }.by(1)
      end
      it '正常に作成できること' do
        circle = build(:circle, content: 'テスト用のサークルです', user: user)
        expect { circle.save }.to change { user.circles.count }.by(1)
      end
    end
    context 'ログインしていない場合' do
      before { post circles_path, params: { post: circle } }
      it 'ログインページにリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'edit' do
    # context '本人の場合' do
    #   before do
    #     sign_in user
    #     get edit_circle_path(circle)
    #   end
    #   it '200レスポンスを返すこと' do
    #     expect(response).to have_http_status 200
    #   end
    # end
    context '本人でない場合' do
      before { sign_in user_2 }
      it 'サークル詳細へリダイレクトされること' do
        get edit_circle_path(circle)
        expect(response).to redirect_to circle_path
      end
    end
    context 'ログインしていない場合' do
      before do
        logout(user)
        get edit_circle_path(circle)
      end
      it 'サインイン画面へリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#update' do
    # context 'ログインしている時' do
    #   before do
    #     sign_in user
    #     patch circle_path(circle), params: { post: circle_2 }
    #   end
    #   it '投稿一覧へリダイレクトされること' do
    #     expect(response).to redirect_to circle_path
    #   end
    # end
    context '本人でない場合' do
      before do
        sign_in user_2
        patch circle_path(circle), params: { post: circle }
      end
      it 'サークル2のcontentが反映されず、ログイン画面へリダイレクトされること' do
        patch circle_path(circle), params: { post: circle_2 }
        expect(circle.reload.content).to eq 'test_circle_content'
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'ログインしていない場合' do
      before { patch circle_path(circle), params: { post: circle } }
      it 'ログインページにリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context '本人の場合' do
      before { sign_in user }
      let!(:circle) { create(:circle, user: user) }
      it '正常に削除できること' do
        expect do
          delete circle_path(circle)
        end.to change { user.circles.count }.by(-1)
      end
    end
    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        delete circle_path(circle)
        expect(response).to redirect_to new_user_session_path
      end
    end
    context '本人でない場合' do
      let!(:circle) { create(:circle, user: user) }
      it 'circleを削除できず、詳細ページにリダイレクトされること' do
        sign_in user_2
        expect { delete circle_path(circle) }.to change { Circle.count }.by(0)
        expect(response).to redirect_to circle_path
      end
    end
  end
  
end
