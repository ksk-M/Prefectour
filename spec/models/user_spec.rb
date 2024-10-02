require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "バリデーションに関するテスト" do
    context "ユーザー名" do
      it "入力されていない場合、エラーになること" do
        user.name = nil
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("お名前を入力してください")
      end

      it "15文字以内の場合、有効" do
        user.name = "a" * 15
        expect(user).to be_valid
      end

      it "16文字以上の場合、エラーになること" do
        user.name = "a" * 16
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("お名前は15文字以内で入力してください")
      end
    end

    context "自己紹介" do
      it "入力されていない場合、有効" do
        user.introduction = nil
        expect(user).to be_valid
      end

      it "80文字以内の場合、有効" do
        user.introduction = "a" * 80
        expect(user).to be_valid
      end

      it "81文字以上の場合、エラーになること" do
        user.introduction = "a" * 81
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("自己紹介は80文字以内で入力してください")
      end
    end
  end
end
