class AddPageIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :page_id, :uuid
    add_index :posts, :page_id
  end
end
