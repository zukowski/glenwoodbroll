class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_collection
  helper_method :current_collection=

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
    return @current_collection if @current_collection
    @current_collection = current_user.collections.where(:id => session[:cid]).first
    Rails.logger.debug(@current_collection.nil?)
    if @current_collection.nil?
      unless current_user.collections.first.nil?
        @current_collection = current_user.collections.first
      else
        @current_collection = Collection.create(:user => current_user, :name => 'New Reel')
      end
      session[:cid] = @current_collection.id
    end
    @current_collection
  end
end
