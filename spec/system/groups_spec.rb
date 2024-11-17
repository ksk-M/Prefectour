require 'rails_helper'

RSpec.describe "Groups", type: :system do
  let(:user) { create(:user) }
  let!(:another_user) { create(:user, name: "another_user") }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  describe "グループ作成" do
    it "グループ名が入力されていない場合、エラーになること" do
      visit new_group_path
      fill_in "グループ名", with: ""
      check "another_user"
      click_button "作成"
      expect(page).to have_content "グループの登録に失敗しました"
    end

    it "グループ名が入力されている場合、有効" do
      visit new_group_path
      fill_in "グループ名", with: "テストグループ"
      check "another_user"
      click_button "作成"
      expect(current_path).to eq group_path(Group.last)
      expect(page).to have_content "「テストグループ」を登録しました"
      within '.group-name' do
        expect(page).to have_content "テストグループ"
      end
    end
  end

  describe "グループ編集" do
    let(:group) { create(:group, name: "テストグループ") }

    it "更新できること" do
      visit edit_group_path(group)
      fill_in "グループ名", with: "update"
      check "another_user"
      click_button "保存"
      expect(current_path).to eq group_path(group)
      expect(page).to have_content "「update」を更新しました"
      within '.group-name' do
        expect(page).to have_content "update"
      end
    end

    it "削除できること" do
      visit edit_group_path(group)
      click_link "グループ削除"
      page.accept_confirm
      expect(current_path).to eq user_path(user)
      expect(page).to have_content "「テストグループ」を削除しました"
      within '.my-groups' do
        expect(page).not_to have_content "テストグループ"
      end
    end
  end
end
