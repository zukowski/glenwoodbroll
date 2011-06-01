class Collection < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :videos

  delegate :empty?, :to => :videos

  validates :user, :presence => true

  def <<(video)
    videos << video unless videos.include?(video)
  end
end
