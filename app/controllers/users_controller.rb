class UsersController < ApplicationController
  def show
    @groups = current_user.groups
    @user_pref = current_user.prefecture_code
    user_plans = current_user.groups.joins(:plans).pluck('plans.id')
    visited_addresses = Destination.joins(:plan_destinations).where(plan_destinations: { plan_id: user_plans },
                                                                    status: "訪問済").distinct.pluck(:address)
    @visited_pref_codes = visited_addresses.map { |address| Destination.extract_prefecture_code(address) }.uniq.compact
  end
end
