class ChangeRecipesTimesColumnsToIntegers < ActiveRecord::Migration[7.0]
  def change
    change_table :recipes do |t|
      t.remove :preparation_time
      t.column :preparation_time, :integer

      t.remove :cooking_time
      t.column :cooking_time, :integer
    end
  end
end
