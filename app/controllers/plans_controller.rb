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

  private

  def plan_params
    params.require(:plan).permit(:title, :note, :start_date, :end_date, :group_id, destination_ids: [])
  end
end
