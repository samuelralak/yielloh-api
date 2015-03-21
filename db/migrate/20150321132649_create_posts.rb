class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts, id: :uuid do |t|
      t.uuid :postable_id
      t.string :postable_type
      t.uuid :user_id

      t.timestamps
    end

    add_index :posts, :user_id
    add_index :posts, [:postable_id, :postable_type]
  end
end
