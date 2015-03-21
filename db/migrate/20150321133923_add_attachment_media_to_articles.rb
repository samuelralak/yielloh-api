class AddAttachmentMediaToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :media
    end
  end

  def self.down
    remove_attachment :articles, :media
  end
end
