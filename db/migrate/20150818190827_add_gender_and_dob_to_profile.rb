class AddGenderAndDobToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :date_of_birth, :timestamp
    add_column :profiles, :gender_id, :uuid
    add_index  :profiles, :gender_id
  end
end
