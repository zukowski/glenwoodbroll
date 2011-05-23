class Video < ActiveRecord::Base
  belongs_to :video_category

  validates :title, :description, :video_category, :presence => true
  validates :duration, :numericality => {:only_integer => true}
end
