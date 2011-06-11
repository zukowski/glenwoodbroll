class CollectionsController < ApplicationController
  load_and_authorize_resource

  def index
  end
  
  # Shows the page that allows the user to build their download
  def show_build
  end

  # Performs the build
  def build
  end

  # Adds a video to the collection
  def populate
    @video = Video.find(params[:video_id])
    render :nothing => true and return if @collection.videos.include? @video
    @collection << @video

    respond_to do |format|
      format.html { redirect_to :back, :notice => "Video added to your reel." }
      format.js
    end
  end

  # Removes a video from the collection
  def depopulate
    @video = Video.find params[:video_id]
    @collection.videos.delete(@video)

    respond_to do |format|
      format.html { redirect_to :back, :notice => "Video removed from your reel." }
      format.js
    end
  end

  # Changes the current collection
  def switch
    @collection = Collection.find params[:collection_id]
    authorize! :read, @collection
    session[:cid] = @collection.id

    respond_to do |format|
      format.html { redirect_to :back, :notice => "Reel changed to #{@collection.name}" }
      format.js
    end
  end

  def create
    @collection.user = current_user
    if @collection.save
      session[:cid] = @collection.id
      redirect_to Video, :notice => 'Reel successfully created'
    else
      redirect_to :back, :alert => 'Reel requires a name'
    end
  end

  def update
    respond_to do |format|
      if @collection.update_attributes params[:collection]
        format.html { redirect_to :back, :notice => 'Reel updated' }
        format.js
      else
        format.html { redirect_to :back, :alert => 'Invalid name' }
        format.js   { render :text => 'alert("Invalid name")' }
      end
    end
  end

  def destroy
    @collection.destroy
    redirect_to Collection, :notice => 'Reel successfully removed'
  end
end
