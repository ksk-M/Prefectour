require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:destination) { create(:destination, category: category, user: user) }

  describe "リレーションに関するテスト" do
    it "Destinationモデルと関連付いていること" do
      expect(category.destinations).to include(destination)
    end
  end
end
