class ChangeAboutToTagline < ActiveRecord::Migration
  def change
      rename_column :profiles, :about, :tagline
  end
end
