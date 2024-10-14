class UsersController < ApplicationController
  def show
    @groups = current_user.groups
    @user_pref = current_user.prefecture_code
  end
end
