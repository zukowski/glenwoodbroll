class ApplicationController < ActionController::Base
  protect_from_forgery

  def render_404
    render :file => "#{Rails.root.to_s}/public/404.html", :status => 404
  end
end
