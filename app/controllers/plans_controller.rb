class PlansController < ApplicationController
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
      redirect_to plan_path(@plan.id)
    else
      @group_id = plan_params[:group_id]
      @selected_destinations = Destination.where(id: plan_params[:destination_ids])
      flash.now[:alert] = "旅行計画の作成に失敗しました"
      render "plans/new"
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @my_plans = Plan.where(group_id: current_user.groups)
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      flash[:notice] = "「#{@plan.title}」を更新しました。"
      redirect_to group_path(@plan.group.id)
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

  private

  def plan_params
    params.require(:plan).permit(:title, :note, :start_date, :end_date, :proposed_plan, :group_id, destination_ids: [])
  end
end
