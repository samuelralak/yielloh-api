# This migration comes from acts_as_taggable_on_engine (originally 1)
class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    create_table :tags, id: :uuid do |t|
      t.string :name
    end

    create_table :taggings, id: :uuid do |t|
      t.uuid :tag_id

      # You should make sure that the column created is
      # long enough to store the required class names.
      t.uuid :taggable_id
      t.string :taggable_type

      t.uuid :tagger_id
      t.string :tagger_type

      # Limit is created to prevent MySQL error on index
      # length for MyISAM table type: http://bit.ly/vgW2Ql
      t.string :context, limit: 128

      t.datetime :created_at
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
