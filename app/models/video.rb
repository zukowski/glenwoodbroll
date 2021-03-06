class Video < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :collections

  validates :title, :description, :category, :presence => true
  validates :duration, :numericality => {:only_integer => true}, :allow_nil => true

  def self.search(params)
    results = scoped
    results = results.where('title LIKE ? OR description LIKE ?', "%#{params['keywords']}%", "%#{params['keywords']}%") unless params['keywords'].blank?
    results = results.where(:category_id => params['category_id']) unless params['category_id'].blank?
    results
  end

  def self.encoding_options
    [['avi', 'avi'],['mp4','mp4']]
  end

  def flv_url
    "https://s3.amazonaws.com/gsrca-flv/flv/" + self.file_name + ".flv"
  end

  def flv_preview_image
   "https://s3.amazonaws.com/gsrca-flv/flv/" + self.file_name + ".jpg"
  end
end
