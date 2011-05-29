class RenameVideoCollectionIdToCollectionIdOnVideoCollectionsVideos < ActiveRecord::Migration
  def self.up
    rename_column :video_collections_videos, :video_collection_id, :collection_id
  end

  def self.down
    rename_column :video_collections_videos, :collection_id, :video_collection_id
  end
end
