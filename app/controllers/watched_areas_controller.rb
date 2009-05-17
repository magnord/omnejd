class WatchedAreasController < ApplicationController
  def create
    @watched_area = WatchedArea.new(:user_id => params[:user_id], :area_id => params[:area_id])

    if !@watched_area.save
      flash[:error] = "Watched area couldn't be successfully created."
    else
      flash[:notice] = "Now watching area #{params[:id]}"
    end
  end

  def destroy
    WatchedArea.destroy(params[:id])
    flash[:notice] = "No longer watching area #{params[:id]}"
  end

end
