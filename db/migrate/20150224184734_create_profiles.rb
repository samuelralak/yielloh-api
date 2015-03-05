class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :fullname
      t.string :username
      t.string :about
      t.string :location
      t.uuid :user_id

      t.timestamps
    end
  end
end
