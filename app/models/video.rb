class Video < ActiveRecord::Base
  validates :title, :description, :presence => true
  validates :duration, :numericality => {:only_integer => true}
end
