class VideosController < ApplicationController
  def index
    @videos = Video.search(search_params)
  end
  
  def show
    @video = Video.find params[:id]
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
  def new
		@video = Video.new
	 
		respond_to do |format|
			format.html
		end
	end
	
  def create
		@video = Video.new(params[:video])
	 
		respond_to do |format|
			if @video.save
				format.html { redirect_to(@video,
											:notice => 'Video record was successfully created. Now upload a video!') }
			else
				format.html { render :action => "new" }
			end
		end
	end

	def edit
		@video = Video.find(params[:id])
	end
  
  def update
  	@video = Video.find(params[:id])
  	if @video.update_attributes(params[:video])
  		redirect_to @video, :notice => 'Video record was successfully updated.'
  	else
  		render "edit"
  	end
  end
  
  def destroy
  	@video = Video.find(params[:id])
  	@video.destroy
  	redirect_to Video, :notice => 'Video record was deleted.'
  end
  
  private
  
	def search_params
    params.select {|k,v| ['category_id','keywords'].include?(k)}
  end
  
end
