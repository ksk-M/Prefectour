class DestinationsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:category_id].present?
      @destinations = current_user.destinations.where(category_id: params[:category_id]).order(created_at: :desc)
      @category = Category.find(params[:category_id])
    else
      @destinations = current_user.destinations.order(created_at: :desc)
    end
  end

  def new
    @destination = Destination.new
    # アクションに応じてバリデーションエラーメッセージを変更
    @new_record = true
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      flash[:notice] = "「#{@destination.name}」を登録しました。"
      redirect_to destinations_path
    else
      flash.now[:alert] = "行きたいところの登録に失敗しました"
      render "destinations/new"
    end
  end

  def show
    @destination = Destination.find(params[:id])
    @destinations = current_user.destinations.order(created_at: :desc)
  end

  def edit
    @destination = Destination.find(params[:id])
    # アクションに応じてバリデーションエラーメッセージを変更
    @new_record = false
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      flash[:notice] = "「#{@destination.name}」を更新しました。"
      redirect_to destinations_path
    else
      flash.now[:alert] = "行きたいところの更新に失敗しました。"
      render "destinations/edit"
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy
    flash[:notice] = "行きたいリストから「#{@destination.name}」を削除しました。"
    redirect_to destinations_path
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :address, :note, :is_private, :latitude, :longitude, :status, :user_id,
:category_id)
  end
end
