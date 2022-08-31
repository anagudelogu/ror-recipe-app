class ChangeRecipesPublicDefaultTrueFalse < ActiveRecord::Migration[7.0]
  def change 
    change_column_default :recipes, :public, from: true, to: false 
  end
end
