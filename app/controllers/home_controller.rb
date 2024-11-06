class HomeController < ApplicationController
  before_action :authenticate_user!

  def top
    redirect_to user_path(current_user)
  end
end
