class PlansController < ApplicationController
  before_action :authenticate_user!

  def new
    @plan = Plan.new
    @group_id = params[:group_id]
    # パラメータはgroups#showのフォームから送られたもの
    @selected_destinations = Destination.where(id: params[:destination_ids])
  end

  def create
    selected_destination_names = Destination.where(id: plan_params[:destination_ids].reject(&:blank?)).pluck(:name)

    if selected_destination_names.blank?
      flash[:alert] = "目的地が選択されていません。"
      return redirect_to group_path(plan_params[:group_id])
    end

    @plan = Plan.new(plan_params)
    if @plan.save
      # バリデーションをパスした場合のみAI提案プランを生成
      @plan.update(proposed_plan: Plan.generate_travel_plan(selected_destination_names, @plan.start_date, @plan.end_date))
      flash[:notice] = "「#{@plan.title}」を作成しました"
      redirect_to plan_path(@plan)
    else
      @group_id = plan_params[:group_id]
      @selected_destinations = Destination.where(id: plan_params[:destination_ids])
      flash.now[:alert] = "旅行計画の作成に失敗しました"
      render "plans/new"
    end
  end

  def show
    @plan = Plan.includes(images_attachments: :blob).find(params[:id])
    @my_plans = Plan.where(group_id: current_user.groups)
    @plan_destinations = @plan.destinations.includes(:category, :user).order('categories.name')
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      flash[:notice] = "「#{@plan.title}」を更新しました。"
      redirect_to plan_path(@plan)
    else
      flash.now[:alert] = "旅行計画の更新に失敗しました。"
      render "plans/edit"
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    flash[:notice] = "「#{@plan.title}」を削除しました。"
    redirect_to group_path(@plan.group_id)
  end

  def edit_status
    @plan = Plan.find(params[:id])
    @destinations = @plan.destinations
  end

  def update_status
    @plan = Plan.find(params[:id])
    visited_destinations = plan_params[:destination_ids].reject(&:blank?)
    if @plan.update(status_params)
      @plan.destinations.where(id: visited_destinations).update_all(status: "訪問済")
      @plan.destinations.where.not(id: visited_destinations).update_all(status: "未訪問")
      flash[:notice] = "「#{@plan.title}」と選択した行きたいリストのステータスを更新しました。"
      redirect_to group_path(@plan.group_id)
    else
      @destinations = @plan.destinations
      flash.now[:alert] = "旅行計画・目的地のステータス更新に失敗しました。"
      render "plans/edit_status"
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :note, :start_date, :end_date, :proposed_plan, :status, :group_id, destination_ids: [])
  end

  def status_params
    params.require(:plan).permit(:status, images: [])
  end
end
