class PlansController < ApplicationController
  def new
    @plan = Plan.new
    @group_id = params[:group_id]
    # パラメータはgroups#showのフォームから送られたもの
    @selected_destinations = Destination.where(id: params[:destination_ids])
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      flash[:notice] = "「#{@plan.title}」を作成しました"
      redirect_to group_path(@plan.group_id)
    else
      @group_id = @plan.group_id
      @selected_destinations = Destination.where(id: @plan.destination_ids)
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
    params.require(:plan).permit(:title, :note, :start_date, :end_date, :group_id, destination_ids: [])
  end
end
