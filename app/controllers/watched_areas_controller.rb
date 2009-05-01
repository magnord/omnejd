class WatchedAreasController < ApplicationController
  def create
    @area = WatchedArea.new(:user_id => params[:user_id], :area_id => params[:area_id])

    if !@area.save
      flash[:error] = "Watched area couldn't be successfully created."
    end
  end

  def destroy
    area = WatchedArea.find(:first, 
      :conditions => ["user_id = ? AND area_id = ?", params(:user_id), params(:area_id)])
    WatchedArea.destroy(area.id)
  end

end
