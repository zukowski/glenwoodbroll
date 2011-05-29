class AddVideoToVideo < ActiveRecord::Migration
  def self.up
    add_column :videos, :video, :string
  end

  def self.down
    remove_column :videos, :video
  end
end
