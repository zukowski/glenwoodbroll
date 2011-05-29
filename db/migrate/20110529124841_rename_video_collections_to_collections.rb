class RenameVideoCollectionsToCollections < ActiveRecord::Migration
  def self.up
    rename_table :video_collections, :collections
  end

  def self.down
    rename_table :collections, :video_collections
  end
end
