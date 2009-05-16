class WatchedAreasController < ApplicationController
  def create
    @area = WatchedArea.new(:user_id => params[:user_id], :area_id => params[:area_id])

    if !@area.save
      flash[:error] = "Watched area couldn't be successfully created."
    end
  end

  def destroy
    WatchedArea.destroy(params[:id])
  end

end
