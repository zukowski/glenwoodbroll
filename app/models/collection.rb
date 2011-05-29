class Collection < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :videos

  validates :user, :presence => true
end
