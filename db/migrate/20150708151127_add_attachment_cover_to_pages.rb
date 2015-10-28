class AddAttachmentCoverToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :pages, :cover
  end
end
