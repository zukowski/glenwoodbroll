class RenameVideoCategoriesToCategories < ActiveRecord::Migration
  def self.up
    rename_table :video_categories, :categories
  end

  def self.down
    rename_table :categories, :video_categories
  end
end
