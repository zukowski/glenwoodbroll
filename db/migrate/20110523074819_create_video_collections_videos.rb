class CreateVideoCollectionsVideos < ActiveRecord::Migration
  def self.up
    create_table :video_collections_videos, :id => false do |t|
      t.references :video
      t.references :video_collection
    end
  end

  def self.down
    drop_table :video_collections_videos
  end
end
