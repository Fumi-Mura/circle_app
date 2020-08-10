# == Schema Information
#
# Table name: circles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  name       :string(255)
#  place      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :integer
#  image_id   :string(255)
#  user_id    :integer
#
require 'rails_helper'

RSpec.describe Circle, type: :model do
  let(:user) { build(:user) }
  let(:circle) { build(:circle) }

  describe 'バリデーション' do
    context 'OKの場合' do
      it 'nameとcontentどちらも値が設定されていればOK' do
        expect(circle.valid?).to eq true
      end
    end

    context 'NGの場合' do
      it 'nameが空だとNG' do
        circle.name = ''
        expect(circle.valid?).to eq false
      end

      it 'contentが空だとNG' do
        circle.content = ''
        expect(circle.valid?).to eq false
      end

      it 'nameが31文字以上だとNG' do
        circle.name = "a" * 31
        expect(circle.valid?).to eq false
      end

      it 'contentが1001文字以上だとNG' do
        circle.content = "a" * 1000
        expect(circle.valid?).to eq true
      end
    end
  end

  describe 'dependent: :destroy' do
    it 'userが削除されたらuserが作成したcircleも削除されること' do
      @user = create(:user)
      @circle = create(:circle, user: @user)
      expect{ @user.destroy }.to change{ Circle.count }.by(-1)
    end
  end
end
