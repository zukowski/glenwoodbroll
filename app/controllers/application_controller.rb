class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_404
    render :file => "#{Rails.root.to_s}/public/404.html", :status => 404
  end

  def current_video_collection
    video_collection = VideoCollection.find_by_id(session[:vc_id])
    if video_collection.nil? && current_user
      video_collection = VideoCollection.create(:user => current_user)
    end
  end
end
