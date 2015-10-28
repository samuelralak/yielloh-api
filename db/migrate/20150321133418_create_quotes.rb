class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes, id: :uuid do |t|
      t.text :content

      t.timestamps
    end
  end
end
