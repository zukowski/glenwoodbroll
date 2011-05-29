class VideoCollectionsController < ApplicationController
  load_and_authorize_resource

  def create
    @collection.user = current_user
    if @video_collection.save
      redirect_to Video, :notice => 'Collection successfully created'
    else
      flash[:error] = 'Collection could not be created'
      redirect_to Collection
    end
  end

  def destroy
    @collection.destroy
    redirect_to Collection, :notice => 'Collection successfully removed'
  end
end
