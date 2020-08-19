require 'rails_helper'

RSpec.describe 'Blogs', type: :request do
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:circle) { create(:circle, user: user) }
  let(:blog) { create(:blog, user: user, circle: circle) }
  let!(:blog_2) { create(:blog, content: "blog_2") }

  describe "#show" do
    before { get blog_path(blog) }

    it '正常なレスポンスが返ってくること' do
      expect(response).to have_http_status(302)
    end
  end

  describe 'create' do
    context 'ログインしている場合' do
      before { sign_in user }

      it '正常に作成できること' do
        expect do
          post blogs_path, params: { post: blog }
        end.to change { user.blogs.count }.by(1)
      end
    end

    context 'ログインしていない場合' do
      before { post blogs_path, params: { post: blog } }

      it 'ログインページにリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'edit' do
    context '本人の場合' do
      before do
        sign_in user
        get edit_blog_path(blog)
      end

      it '200レスポンスを返すこと' do
        expect(response).to have_http_status 200
      end
    end

    context '本人でない場合' do
      before { sign_in user_2 }

      it 'blogページへリダイレクトされること' do
        get edit_blog_path(blog)
        expect(response).to redirect_to blog_path
      end
    end

    context 'ログインしていない場合' do
      before do
        logout(user)
        get edit_blog_path(blog)
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
    #     patch blog_path(blog), params: { post: blog }
    #   end
    #   it '投稿へリダイレクトされること' do
    #     expect(response).to redirect_to blog_path
    #   end
    # end
    context '本人でない場合' do
      before do
        sign_in user_2
        patch blog_path(blog), params: { post: blog }
      end

      it 'blog_2のcontentが反映されず、サークル一覧にリダイレクトされること' do
        patch blog_path(blog), params: { post: blog_2 }
        expect(blog.reload.content).to eq 'test_blog_content'
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'ログインしていない場合' do
      before { patch blog_path(blog), params: { post: blog } }

      it 'ログインページにリダイレクトされること' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    context '本人の場合' do
      before { sign_in user }

      let!(:blog) { create(:blog, user: user, circle: circle) }

      it '正常に削除できること' do
        expect do
          delete blog_path(blog)
        end.to change { user.blogs.count }.by(-1)
      end
    end

    context '未ログイン状態のとき' do
      it 'ログインページにリダイレクトされること' do
        delete blog_path(blog)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context '本人でない場合' do
      let!(:blog) { create(:blog, user: user, circle: circle) }

      it 'blogを削除できず、詳細ページにリダイレクトされること' do
        sign_in user_2
        expect { delete blog_path(blog) }.to change(Blog, :count).by(0)
        expect(response).to redirect_to blog_path
      end
    end
  end
end
