class VideosController < ApplicationController
  load_and_authorize_resource

  def index
    @videos = @videos.search(search_params)
  end
  
  def show
  end
  
  def new
  	@video_select_options = video_select_options
  end
	
  def create
    if @video.save
      redirect_to @video, :notice => 'Video record was successfully created. Now upload a video!'
    else
      render :new
    end
  end

  def edit
  	@video_select_options = video_select_options
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
  
  def video_select_options
  	Dir.chdir(RAILS_ROOT + "/assets/videos/avi")
  	@files = Dir["*.*"]
  	@video_select_options = []
  	@files.each { |v| @video_select_options << [v.gsub(/\.[a-zA-Z0-0]{3,4}/,''),v] }
  	@video_select_options
  end
  
  def search_params
    params.select {|k,v| ['category_id','keywords'].include?(k)}
  end
end
