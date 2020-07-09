# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  circle_id  :integer
#  image_id   :string(255)
#  user_id    :integer
#
require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:user) { build(:user) }
  let(:circle) { build(:circle) }
  let(:blog) { build(:blog) }

  describe 'バリデーション' do
    context 'OKの場合' do
      it 'titleとcontentどちらも値が設定されていればOK' do
        expect(blog.valid?).to eq true
      end
    end
    context 'NGの場合' do
      it 'titleが空だとNG' do
        blog.title = ''
        expect(blog.valid?).to eq false
      end
      
      it 'contentが空だとNG' do
        blog.content = ''
        expect(blog.valid?).to eq false
      end
      
      it 'titleが51文字以上だとNG' do
        blog.title = "a" * 51
        expect(blog.valid?).to eq false
      end
      
      it 'contentが1001文字以上だとNG' do
        blog.content = "a" * 1001
        expect(blog.valid?).to eq false
      end
    end
  end
  
  describe 'dependent: :destroy' do
    before do
      @user = create(:user)
      @circle = create(:circle, user: @user)
      @blog = create(:blog, user: @user, circle: @circle)
    end
    it 'userが削除されたらuserが投稿したblogも削除されること' do
      expect{ @user.destroy }.to change{ Blog.count }.by(-1)
    end
    
    it 'circleが削除されたらそのcircleで投稿されたblogも削除されること' do
      expect{ @circle.destroy }.to change{ Blog.count }.by(-1)
    end
  end
end