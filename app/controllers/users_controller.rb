class UsersController < ApplicationController
  def show
    @groups = current_user.groups
  end
end
