class VideosController < ApplicationController
  load_and_authorize_resource

  def index
    @videos = @videos.search(search_params)
  end
  
  def show
  end
  
  def new
  	@video_select_options = video_select_options
    flash.now.alert = 'No Videos Available' if @video_select_options.empty?
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
    bucket = s3_bucket
    keys = bucket.keys.map(&:to_s)
    keys = keys.select {|k| k =~ /^videos\/.*\.avi$/}.map {|k| k.gsub('videos/','').gsub('.avi','')}
    #existing_keys = Video.all.map(&:file_name)
    #keys.reject {|k| existing_keys.include? k}
  end
  
  def search_params
    params.select {|k,v| ['category_id','keywords'].include?(k)}
  end
end
