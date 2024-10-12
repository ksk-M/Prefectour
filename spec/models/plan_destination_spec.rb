require 'rails_helper'

RSpec.describe PlanDestination, type: :model do
  let(:plan_destination) { create(:plan_destination) }

  describe "リレーションに関するテスト" do
    it "plan_idが無い場合、エラーになること" do
      plan_destination.plan_id = nil
      expect(plan_destination).to be_invalid
    end

    it "destination_idが無い場合、エラーになること" do
      plan_destination.destination_id = nil
      expect(plan_destination).to be_invalid
    end

    it "plan_idとdestination_idが両方存在する場合、有効" do
      expect(plan_destination).to be_valid
    end
  end
end
