class RenameVideoCollectionsVideosToCollectionsVideos < ActiveRecord::Migration
  def self.up
    rename_table :video_collections_videos, :collections_videos
  end

  def self.down
    rename_table :collections_videos, :video_collections_videos
  end
end
