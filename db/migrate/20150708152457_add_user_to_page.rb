class AddUserToPage < ActiveRecord::Migration
  def change
    add_column :pages, :user_id, :uuid
    add_index :pages, :user_id
  end
end
