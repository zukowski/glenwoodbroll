class Video < ActiveRecord::Base
  belongs_to :video_category
  has_and_belongs_to_many :video_collections

  #validates :title, :description, :video_category, :presence => true
  validates :title, :description, :presence => true
  validates :duration, :numericality => {:only_integer => true}
  
  mount_uploader :video, VideoUploader
 
end
