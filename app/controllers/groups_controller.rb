class GroupsController < ApplicationController
  before_action :authenticate_user!

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
    @plans = @group.plans.order(start_date: :desc)
    group_users = @group.users.includes(:destinations)

    # 都道府県の絞り込み機能
    if params[:prefecture].present?
      @visible_destinations = group_users.index_with do |user|
        user.destinations.where(is_private: false).where("address LIKE ?", "%#{params[:prefecture]}%").order(created_at: :desc)
      end
    else
      @visible_destinations = group_users.index_with do |user|
        user.destinations.where(is_private: false).order(created_at: :desc)
      end
    end
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
