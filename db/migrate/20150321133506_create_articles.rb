class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, id: :uuid do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
