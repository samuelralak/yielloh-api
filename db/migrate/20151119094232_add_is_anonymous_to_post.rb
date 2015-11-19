class AddIsAnonymousToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_anonymous, :boolean, default: false
  end
end
