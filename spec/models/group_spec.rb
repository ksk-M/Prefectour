require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group) { create(:group) }

  describe "バリデーションに関するテスト" do
    context "グループ名" do
      it "入力されていない場合、エラーになること" do
        group.name = nil
        expect(group).to be_invalid
        expect(group.errors.full_messages).to include("グループ名を入力してください")
      end

      it "15文字以内の場合、有効" do
        group.name = "a" * 15
        expect(group).to be_valid
      end

      it "16文字以上の場合、エラーになること" do
        group.name = "a" * 16
        expect(group).to be_invalid
        expect(group.errors.full_messages).to include("グループ名は15文字以内で入力してください")
      end
    end
  end
end
