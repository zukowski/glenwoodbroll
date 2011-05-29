class Video < ActiveRecord::Base
  belongs_to :video_category
  has_and_belongs_to_many :video_collections

  validates :title, :description, :video_category, :presence => true
  validates :duration, :numericality => {:only_integer => true}
  
  mount_uploader :video, VideoUploader
 
  def self.search(params)
    results = scoped
    results = results.where('title LIKE ? OR description LIKE ?', "%#{params[:keywords]}%", "%#{params[:keywords]}%")
    results = results.where(:video_category_id => params[:category_id]) unless params[:category_id].blank?
    results
  end
  
end
