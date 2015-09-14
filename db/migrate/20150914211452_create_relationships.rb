class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships, id: :uuid do |t|
      t.uuid :follower_id
      t.uuid :followed_id

      t.timestamps null: false
    end
  end
end
