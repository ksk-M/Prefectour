require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:group) { create(:group) }
  let(:destination) { create(:destination) }
  let(:plan) { create(:plan, group: group, destinations: [destination]) }

  describe "バリデーションに関するテスト" do
    context "タイトル" do
      it "入力されていない場合、エラーになること" do
        plan.title = nil
        expect(plan).to be_invalid
        expect(plan.errors.full_messages).to include("タイトルを入力してください")
      end

      it "25文字以内の場合、有効" do
        plan.title = "a" * 25
        expect(plan).to be_valid
      end

      it "26文字以上の場合、エラーになること" do
        plan.title = "a" * 26
        expect(plan).to be_invalid
        expect(plan.errors.full_messages).to include("タイトルは25文字以内で入力してください")
      end
    end

    context "日付の検証" do
      it "開始日が終了日より後の場合、エラーになること" do
        plan.start_date = Date.tomorrow
        plan.end_date = Date.today
        expect(plan).to be_invalid
        expect(plan.errors.full_messages).to include("終了日は開始日より後の日付にしてください。")
      end

      it "終了日が開始日より後の場合、有効" do
        plan.start_date = Date.today
        plan.end_date = Date.tomorrow
        expect(plan).to be_valid
      end
    end
  end

  describe "リレーションに関するテスト" do
    it "グループに属していること" do
      expect(plan.group).to eq(group)
    end

    it "複数の目的地を持てること" do
      destination2 = create(:destination)
      plan.destinations << [destination2]
      expect(plan.destinations.count).to eq(2)
    end
  end
end
