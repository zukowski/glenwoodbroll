Factory.define :collection do |f|
  f.user { Factory(:user) }
end

Factory.define :collection_with_videos, :parent => :collection do |f|
  f.after_create do |collection|
    3.times { collection.videos << Factory(:video) }
  end
end
