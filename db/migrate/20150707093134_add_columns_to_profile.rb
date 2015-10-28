class AddColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :twitter_handle, :string
    add_column :profiles, :facebook_handle, :string
  end
end
