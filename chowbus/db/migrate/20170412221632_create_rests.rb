class CreateRests < ActiveRecord::Migration
  def change
    create_table :rests do |t|
      t.string :name
      t.text :location
      t.references :Zone, index: true, foreign_key: true
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
