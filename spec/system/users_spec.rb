require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "新規登録" do
    context "必須項目が入力されている場合" do
      it "ユーザー登録が成功すること" do
        visit new_user_registration_path
        fill_in "お名前", with: "テストユーザー"
        fill_in "メールアドレス", with: "test@test.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード（確認用）", with: "password"
        click_button "新規登録"

        user = User.last # 登録したユーザーを取得
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "入力に不備がある場合" do
      it "ユーザー登録が失敗すること" do
        visit new_user_registration_path
        fill_in "お名前", with: ""
        fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        fill_in "パスワード（確認用）", with: ""
        click_button "新規登録"
        expect(page).to have_content("お名前を入力してください")
        expect(page).to have_content("メールアドレスを入力してください")
        expect(page).to have_content("パスワードを入力してください")
      end
    end
  end

  describe "ログイン" do
    let(:user) { create(:user) }

    context "認証情報が正しい場合" do
      it "ログインできること" do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        expect(current_path).to eq user_path(user.id)
        expect(page).to have_content "ログインしました。"
      end
    end

    context "認証情報に誤りがある場合" do
      it "ログインに失敗すること" do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: "missPassword"
        click_button "ログイン"
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
      end
    end
  end
end