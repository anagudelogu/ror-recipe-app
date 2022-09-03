class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.time :preparation_time
      t.time :cooking_time
      t.text :description, null: false
      t.boolean :public, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
