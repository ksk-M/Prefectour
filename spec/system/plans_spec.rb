require 'rails_helper'

RSpec.describe "Plans", type: :system do
  let(:user) { create(:user) }
  let(:group) { create(:group, users: [user]) }
  let!(:destination) { create(:destination, name: "大阪城", user: user) }
  let(:plan) { create(:plan, group: group, destinations: [destination]) }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  describe "旅行プラン作成" do
    before do
      visit group_path(group)
      check "大阪城"
      click_button '旅行プラン作成に進む'
    end

    it "旅行プラン作成画面に遷移すること" do
      expect(current_path).to eq new_plan_path
      expect(page).to have_content "大阪城"
    end

    it "入力に不備がある場合、エラーになること" do
      click_button 'AI提案プランを生成（数秒要します）'
      expect(page).to have_content "タイトルを入力してください"
    end

    it "必須項目が入力されている場合、有効" do
      fill_in 'タイトル', with: 'AI大阪旅'
      fill_in 'plan_start_date', with: "#{ Date.today }"
      fill_in 'plan_end_date', with: "#{ Date.tomorrow }"
      click_button 'AI提案プランを生成（数秒要します）'
      expect(current_path).to eq plan_path(Plan.last)
      expect(page).to have_content "AI大阪旅"
      within '.table' do
        expect(page).to have_content "大阪城"
      end
    end
  end

  describe "旅行プラン編集" do
    it "更新できること" do
      visit edit_plan_path(plan)
      fill_in "メモ", with: "豊臣秀吉によって築城"
      click_button "更新"
      expect(current_path).to eq plan_path(plan)
      expect(page).to have_content "豊臣秀吉によって築城"
    end

    it "削除できること" do
      visit plan_path(plan)
      click_link "削除"
      page.accept_confirm
      expect(current_path).to eq group_path(group)
      expect(page).to have_content "「example」を削除しました。"
      within '.plan-list' do
        expect(page).not_to have_content "example"
      end
    end
  end
end
