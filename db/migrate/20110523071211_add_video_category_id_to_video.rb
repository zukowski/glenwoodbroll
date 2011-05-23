class AddVideoCategoryIdToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :video_category_id, :integer
  end

  def self.down
    remove_column :videos, :video_category_id
  end
end
