class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: :destroy

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーは削除できません。"
      redirect_to user_path(current_user)
    end
  end
end
