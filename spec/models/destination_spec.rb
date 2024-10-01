require 'rails_helper'

RSpec.describe Destination, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:destination) { create(:destination, category: category, user: user) }

  describe "バリデーションに関するテスト" do
    context "name" do
      it "入力されていない場合、エラーになること" do
        destination.name = nil
        expect(destination).to be_invalid
        expect(destination.errors.full_messages).to include("場所の名前、住所は空欄にできません")
      end

      it "20文字以内の場合、有効" do
        destination.name = "a" * 20
        expect(destination).to be_valid
      end

      it "20文字以上の場合、エラーになること" do
        destination.name = "a" * 21
        expect(destination).to be_invalid
        expect(destination.errors.full_messages).to include("場所の名前は20文字以内で入力してください")
      end
    end

    context "address" do
      it "入力されていない場合、エラーになること" do
        destination.address = nil
        expect(destination).to be_invalid
        expect(destination.errors.full_messages).to include("場所の名前、住所は空欄にできません")
      end

      it "60文字以内の場合、有効" do
        destination.address = "a" * 60
        expect(destination).to be_valid
      end

      it "60文字以上の場合、エラーになること" do
        destination.address = "a" * 61
        expect(destination).to be_invalid
        expect(destination.errors.full_messages).to include("住所は60文字以内で入力してください")
      end
    end

    context "緯度・経度" do
      it "入力されていない場合、エラーになること" do
        destination.latitude = nil
        destination.longitude = nil
        expect(destination).to be_invalid
        expect(destination.errors.full_messages).to include("場所の名前、住所は空欄にできません")
      end

      it "入力済みの場合、有効" do
        destination.latitude = 1.5
        destination.longitude = 1.5
        expect(destination).to be_valid
      end
    end
  end

  describe "リレーションに関するテスト" do
    it "Userモデルと関連付いていること" do
      expect(destination.user_id).to eq user.id
    end

    it "Categoryモデルと関連付いていること" do
      expect(destination.category_id).to eq category.id
    end
  end
end
