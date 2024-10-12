require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create(:user) }
  let(:destination) { create(:destination, user: user) }
  let(:category) { create(:category, destinations: [destination]) }

  describe "リレーションに関するテスト" do
    it "複数の行きたいリストを持てること" do
      destination2 = create(:destination)
      category.destinations << destination2
      expect(category.destinations.count).to eq(2)
    end
  end
end
