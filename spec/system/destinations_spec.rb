require 'rails_helper'

RSpec.describe "Destinations", type: :system do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:destination) { create(:destination, category: category, user: user) }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  describe "新規作成" do
    it "入力に不備がある場合、エラーになること" do
      visit new_destination_path
      fill_in "destination[name]", with: ""
      fill_in "destination[address]", with: ""
      click_button "保存"

      expect(page).to have_content "地図で場所を検索してください"
    end

    it "必須項目が入力されている場合、有効" do
      visit new_destination_path
      fill_in "destination[name]", with: "東京タワー"
      fill_in "destination[address]", with: "日本、〒105-0011 東京都港区芝公園４丁目２−８"
      execute_script("document.getElementById('lat').value = 35.6585805;")
      execute_script("document.getElementById('lng').value = 139.7454329;")
      click_button "保存"

      expect(current_path).to eq destinations_path
      within '.destinations-table' do
        expect(page).to have_content("東京タワー")
      end
    end
  end

  describe "編集" do
    it "更新できること" do
      visit edit_destination_path(destination.id)
      fill_in "destination[name]", with: "update"
      click_button "保存"

      expect(current_path).to eq destinations_path
      expect(page).to have_content "「update」を更新しました。"
      within '.destinations-table' do
        expect(page).to have_content("update")
      end
    end

    it "削除できること" do
      visit destination_path(destination.id)
      click_link "削除"
      page.accept_confirm

      expect(current_path).to eq destinations_path
      expect(page).to have_content "行きたいところリストから「example」を削除しました。"
      within '.destinations-table' do
        expect(page).not_to have_content("example")
      end
    end
  end
end
