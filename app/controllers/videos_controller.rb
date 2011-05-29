class VideosController < ApplicationController
  def index
    @videos = Video.search(search_params)
  end

  def show
    @video = Video.find params[:id]
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  private

  def search_params
    params.select {|k,v| ['category_id','keywords'].include?(k)}
  end
end
