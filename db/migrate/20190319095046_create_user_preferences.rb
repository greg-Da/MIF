class CreateUserPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :user_preferences do |t|
      t.references :user, foreign_key: true
      t.references :preference, foreign_key: true
      t.integer :position
      t.timestamps
    end
  end
end
