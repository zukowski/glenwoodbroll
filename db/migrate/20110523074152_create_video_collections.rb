class CreateVideoCollections < ActiveRecord::Migration
  def self.up
    create_table :video_collections do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :video_collections
  end
end
