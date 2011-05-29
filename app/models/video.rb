class Video < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :collections

  validates :title, :description, :category, :presence => true
  validates :duration, :numericality => {:only_integer => true}, :allow_nil => true
  
  mount_uploader :video, VideoUploader
 
  def self.search(params)
    results = scoped
    results = results.where('title LIKE ? OR description LIKE ?', "%#{params[:keywords]}%", "%#{params[:keywords]}%")
    results = results.where(:category_id => params[:category_id]) unless params[:category_id].blank?
    results
  end
  
end
