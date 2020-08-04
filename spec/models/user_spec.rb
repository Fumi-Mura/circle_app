# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)
#  profile_text           :text(65535)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  profile_image_id       :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

# Deviceのテスト
RSpec.describe "UserAuthentications", type: :request do
  let(:user) { build(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

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
        end.to_not change(User, :count)
      end
    end

    context 'メールアドレスが大文字で入力された時' do
      it '大文字から小文字に変換すること' do
        user.email = "TeSt@ExAmPlE.CoM"
        user.save!
        expect(user.email.downcase).to eq user.reload.email
      end
    end

    context 'パスワードの入力が6桁の時' do
      it 'パスワードの入力が正しいこと' do
        user = build(:user, password: "a" * 6, password_confirmation: "a" * 6)
        expect(user.valid?).to eq true
      end
    end

    context 'パスワードの入力が5桁の時' do
      it 'パスワードの入力が正しくないこと' do
        user = build(:user, password: "a" * 6, password_confirmation: "a" * 5)
        expect(user.valid?).to eq false
      end
    end

    context 'パスワードが空白の時' do
      it 'パスワードの入力が正しいこと' do
        user = build(:user, password: "" * 6, password_confirmation: "" * 6)
        expect(user.valid?).to eq false
      end
    end

  end
end

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'バリデーション' do
    context 'okの場合' do
      it 'nameとemail,password,password_confirmationが設定されていればOK' do
        expect(user.valid?).to eq true
      end
    end

    context 'NGの場合' do
      it 'nameが空だとNG' do
        user.name = ''
        expect(user.valid?).to eq false
      end

      it 'emailが空だとNG' do
        user.email = ''
        expect(user.valid?).to eq false
      end

      it 'nameが31文字以上だとNG' do
        user.name = "a" * 31
        expect(user.valid?).to eq false
      end

      it 'profile_textが201文字以上だとNG' do
        user.profile_text = "a" * 201
        expect(user.valid?).to eq false
      end
    end
  end

  describe 'フォロー機能' do
    let(:other_user) { create(:user) }
    before { user.save }

    describe 'following?(other_user)' do
      it 'フォローしていない場合、falseを返すこと' do
        expect(user.following?(other_user)).to eq false
      end

      it 'フォローしている場合、trueを返すこと' do
        user.following << other_user
        expect(user.following?(other_user)).to eq true
      end
    end

    describe 'follow(other_user)' do
      it 'フォローしていない場合、フォローできること' do
        user.unfollow(other_user)
        expect { user.follow(other_user) }.to change{ user.following.count }.by(1)
        expect(user.following?(other_user)).to eq true
      end

      it 'フォローしている場合、nilを返すこと' do
        user.follow(other_user)
        expect(user.follow(other_user)).to eq nil
      end

      it '自分自身をフォローできないこと' do
        expect(user.follow(user)).to eq nil
      end
    end

    describe 'unfollow(other_user)' do
      example 'フォローしていない場合、nilを返すこと' do
        expect(user.unfollow(other_user)).to eq nil
      end

      example 'フォローしている場合、フォロー解除できること' do
        user.follow(other_user)
        user.unfollow(other_user)
        expect(user.following?(other_user)).to eq false
      end
    end
  end
end

