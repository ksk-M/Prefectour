class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params_with_current_user)
    if @group.save
      flash[:notice] = "「#{@group.name}」を登録しました"
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "グループの登録に失敗しました"
      render "groups/new"
    end
  end

  def show
    @group = Group.find(params[:id])
    group_users = @group.users.includes(:destinations)
    @visible_destinations = group_users.index_with { |user| user.destinations.where.not(is_private: true) }
    @plans = @group.plans
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params_with_current_user)
      flash[:notice] = "「#{@group.name}」を更新しました"
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "グループの更新に失敗しました"
      render "groups/edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "「#{@group.name}」を削除しました"
    redirect_to user_path(current_user.id)
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end

  def group_params_with_current_user
    params = group_params
    params[:user_ids] << current_user.id
    params
  end
end
