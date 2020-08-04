# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :bigint
#
# Indexes
#
#  index_comments_on_blog_id  (blog_id)
#
# Foreign Keys
#
#  fk_rails_...  (blog_id => blogs.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { build(:user) }
  let(:circle) { build(:circle) }
  let(:blog) { build(:blog) }
  let(:comment) { build(:comment) }

  describe 'バリデーション' do
    context 'OKの場合' do
      it 'nameとcontentどちらも値が設定されていればOK' do
        expect(comment.valid?).to eq true
      end
    end

    context 'NGの場合' do
      it 'nameが空だとNG' do
        comment.name = ''
        expect(comment.valid?).to eq false
      end

      it 'contentが空だとNG' do
        comment.comment = ''
        expect(comment.valid?).to eq false
      end

      it 'nameが31文字以上だとNG' do
        comment.name = "a" * 31
        expect(comment.valid?).to eq false
      end

      it 'contentが101文字以上だとNG' do
        comment.comment = "a" * 101
        expect(comment.valid?).to eq false
      end
    end
  end

  describe 'dependent: :destroy' do
    before do
      @user = create(:user)
      @circle = create(:circle, user: @user)
      @blog = create(:blog, user: @user, circle: @circle)
      @comment = create(:comment, blog: @blog)
    end
    it 'userが削除されたらそのuserが投稿したcommentも削除されること' do
      expect{ @user.destroy }.to change{ Comment.count }.by(-1)
    end

    it 'circleが削除されたらそのサークルのblogに投稿されたcommentも削除されること' do
      expect{ @circle.destroy }.to change{ Comment.count }.by(-1)
    end

    it 'blogが削除されたらuserが投稿したcommentも削除されること' do
      expect{ @blog.destroy }.to change{ Comment.count }.by(-1)
    end
  end
end
