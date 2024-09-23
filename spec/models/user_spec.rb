require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "ユーザー名" do
    context "入力されていない場合" do
      it "エラーになること" do
        user.name = nil
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("お名前を入力してください")
      end
    end

    context "15文字以下の場合" do
      it "有効であること" do
        user.name = "a" * 15
        expect(user).to be_valid
      end
    end

    context "16文字以上の場合" do
      it "エラーになること" do
        user.name = "a" * 16
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("お名前は15文字以内で入力してください")
      end
    end
  end

  describe "自己紹介" do
    context "入力されていない場合" do
      it "有効であること" do
        user.introduction = nil
        expect(user).to be_valid
      end
    end

    context "80文字以下の場合" do
      it "有効であること" do
        user.introduction = "a" * 80
        expect(user).to be_valid
      end
    end

    context "81文字以上の場合" do
      it "エラーになること" do
        user.introduction = "a" * 81
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("自己紹介は80文字以内で入力してください")
      end
    end
  end
end
