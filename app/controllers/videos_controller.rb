class VideosController < ApplicationController
  load_and_authorize_resource

  def index
    @videos = @videos.search(search_params)
  end
  
  def show
  end
  
  def new
  	Dir.chdir(RAILS_ROOT + "/assets/videos/avi")
  	@files = Dir["*.*"]
  	@videos = []
  	@files.each { |v| @videos << [v.gsub(/\.[a-zA-Z0-0]{3,4}/,''),v] }
  end
	
  def create
    if @video.save
      redirect_to @video, :notice => 'Video record was successfully created. Now upload a video!'
    else
      render :new
    end
  end

  def edit
  end
  
  def update
  	if @video.update_attributes(params[:video])
      redirect_to @video, :notice => 'Video record was successfully updated.'
  	else
      render "edit"
  	end
  end
  
  def destroy
  	@video.destroy
  	redirect_to Video, :notice => 'Video record was deleted.'
  end
  
  private
  
  def search_params
    params.select {|k,v| ['category_id','keywords'].include?(k)}
  end
end
