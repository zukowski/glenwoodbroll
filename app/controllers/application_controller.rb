class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_collection

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_url, :alert => exception.message
    else
      redirect_to new_user_session_url, :alert => exception.message
    end
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    render :file => "#{Rails.root.to_s}/public/404.html", :status => 404
  end

  def current_collection
    collection = Collection.find_by_id(session[:cid]) || current_user.collections.first
    collection ||= Collection.create(:user => current_user)
  end
end
