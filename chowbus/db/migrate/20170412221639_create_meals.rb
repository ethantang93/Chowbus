class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.text :detail
      t.references :Rest, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
