class DestinationsController < ApplicationController
  def index
    @destinations = current_user.destinations
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      flash[:notice] = "「#{@destination.name} 」を登録しました。"
      redirect_to destinations_path
    else
      flash.now[:alert] = "行きたいところの登録に失敗しました"
      render "destinations/new"
    end
  end

  def show
    @destination = Destination.find(params[:id])
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      flash[:notice] = "「#{@destination.name} 」を更新しました。"
      redirect_to destinations_path
    else
      flash.now[:alert] = "行きたいところの更新に失敗しました。"
      render "destinations/edit"
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy
    flash[:notice] = "行きたいところリストから「#{@destination.name}」を削除しました。"
    redirect_to destinations_path
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :note, :is_private, :latitude, :longitude, :user_id)
  end
end
