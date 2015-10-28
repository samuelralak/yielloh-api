class CreateGenders < ActiveRecord::Migration
	def migrate(direction)
        super
        # Create gender
        Gender.create!(name: 'male', code: 'MALE', is_active: true) if direction == :up
        Gender.create!(name: 'female', code: 'FEMALE', is_active: true) if direction == :up
    end

    def change
    	create_table :genders, id: :uuid do |t|
    		t.string :name
    		t.string :code
    		t.boolean :is_active

    		t.timestamps null: false
    	end
  	end
end
