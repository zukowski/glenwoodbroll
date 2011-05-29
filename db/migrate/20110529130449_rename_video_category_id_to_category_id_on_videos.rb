class RenameVideoCategoryIdToCategoryIdOnVideos < ActiveRecord::Migration
  def self.up
    rename_column :videos, :video_category_id, :category_id
  end

  def self.down
    rename_column :videos, :category_id, :video_category_id
  end
end
