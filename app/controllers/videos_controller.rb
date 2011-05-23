class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find params[:id]
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
