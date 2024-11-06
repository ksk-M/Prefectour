class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @groups = current_user.groups
    @user_pref = current_user.prefecture_code
    user_plans = @groups.joins(:plans).pluck('plans.id')
    visited_addresses = Destination.joins(:plan_destinations).where(plan_destinations: { plan_id: user_plans },
                                                                    status: "訪問済").distinct.pluck(:address)
    @visited_pref_codes = visited_addresses.map { |address| Destination.extract_prefecture_code(address) }.uniq.compact
    @latest_plan = Plan.joins(:group).where(groups: { id: current_user.group_ids }).order(start_date: :desc).first
    @count_days = @latest_plan.present? ? (@latest_plan.start_date - Date.current).to_i : nil
    @plans = Plan.where(id: user_plans).order(start_date: :desc)
  end
end
