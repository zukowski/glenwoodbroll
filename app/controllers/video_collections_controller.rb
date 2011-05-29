class VideoCollectionsController < ApplicationController
  load_and_authorize_resource

  def create
    @video_collection.user = current_user
    if @video_collection.save
      redirect_to Video, :notice => 'Collection successfully created'
    else
      flash[:error] = 'Collection could not be created'
      redirect_to VideoCollection
    end
  end

  def destroy
    @video_collection.destroy
    redirect_to VideoCollection, :notice => 'Collection successfully removed'
  end
end
