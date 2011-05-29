class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find params[:id]
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
  def new
		@video = Video.new
	 
		respond_to do |format|
			format.html # new.html.erb
		end
	end
	
	def edit
		@post = Video.find(params[:id])
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
  
end
