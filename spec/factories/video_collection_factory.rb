Factory.define :video_collection do |f|
  f.user { Factory(:user) }
end

Factory.define :video_collection_with_videos, :parent => :video_collection do |f|
  f.after_create do |collection|
    3.times { collection.videos << Factory(:video) }
  end
end
