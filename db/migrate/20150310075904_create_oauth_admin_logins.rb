class CreateOauthAdminLogins < ActiveRecord::Migration
  def change
    create_table :oauth_admin_logins, id: :uuid do |t|
      t.uuid :user_id
      t.string :access_token
      t.boolean :is_logged_in, null: false, default: false

      t.timestamps
    end

    add_index :oauth_admin_logins, :user_id
    add_index :oauth_admin_logins, :access_token, unique: true
    add_index :oauth_admin_logins, [:user_id, :access_token]
  end
end
