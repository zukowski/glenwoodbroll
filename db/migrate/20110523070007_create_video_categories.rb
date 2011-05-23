class CreateVideoCategories < ActiveRecord::Migration
  def self.up
    create_table :video_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :video_categories
  end
end
