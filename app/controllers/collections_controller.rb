class CollectionsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def populate
    @collection = Collection.find(params[:id])
    @video = Video.find(params[:video_id])
    @collection << @video
    redirect_to :back, :notice => "Video added to your collection."
  end

  def switch
    @collection = Collection.find(params[:collection][:id])
    authorize! :read, @collection
    session[:cid] = @collection.id
    redirect_to :back, :notice => "Collection changed to #{@collection.name}"
  end

  def create
    @collection.user = current_user
    if @collection.save
      session[:cid] = @collection.id
      redirect_to Video, :notice => 'Collection successfully created'
    else
      redirect_to :back, :alert => 'Collection requires a name'
    end
  end

  def update
    if @collection.update_attributes(params[:collection])
      redirect_to :back, :notice => 'Collection updated'
    else
      redirect_to :back, :alert => 'Invalid name'
    end
  end

  def destroy
    @collection.destroy
    redirect_to Collection, :notice => 'Collection successfully removed'
  end
end
