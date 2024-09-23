require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { create(:group) }

  describe "グループ名" do
    context "入力されていない場合" do
      it "エラーになること" do
        group.name = nil
        expect(group).to be_invalid
        expect(group.errors.full_messages).to include("グループ名を入力してください")
      end
    end

    context "15文字以下の場合" do
      it "有効であること" do
        group.name = "a" * 15
        expect(group).to be_valid
      end
    end

    context "16文字以上の場合" do
      it "エラーになること" do
        group.name = "a" * 16
        expect(group).to be_invalid
        expect(group.errors.full_messages).to include("グループ名は15文字以内で入力してください")
      end
    end
  end
end
