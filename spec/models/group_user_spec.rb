require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  let(:group_user) { create(:group_user) }

  describe "リレーションに関するテスト" do
    it "user_idが無い場合、エラーになること" do
      group_user.user_id = nil
      expect(group_user).to be_invalid
    end

    it "group_idが無い場合、エラーになること" do
      group_user.group_id = nil
      expect(group_user).to be_invalid
    end

    it "user_idとgroup_idが両方存在する場合、有効" do
      expect(group_user).to be_valid
    end
  end
end
