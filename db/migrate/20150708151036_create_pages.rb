class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages, id: :uuid do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
