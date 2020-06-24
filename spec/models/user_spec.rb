require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#name" do
    context "userが登録される場合"
      it "nameが入っている場合"
      expect(FactoryBot.build(:user)).to.be_valid
  end
end
