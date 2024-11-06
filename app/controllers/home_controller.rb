class HomeController < ApplicationController
  def top
    redirect_to user_path(current_user)
  end
end
