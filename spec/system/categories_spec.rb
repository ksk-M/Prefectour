require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:category_2) { create(:category, name: "グルメ") }
  let!(:destination) { create(:destination, name: "東京タワー", category: category, user: user) }
  let!(:destination_tako) { create(:destination, name: "たこ焼き屋", category: category_2, user: user) }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  it "選択したカテゴリーで一覧を絞り込めること" do
    visit destinations_path
    select "その他", from: "category_id"
    click_button "絞り込む"

    expect(current_path).to eq destinations_path
    within '.destinations-table' do
      expect(page).to have_content("東京タワー")
      expect(page).not_to have_content("たこ焼き屋")
    end
  end
end
