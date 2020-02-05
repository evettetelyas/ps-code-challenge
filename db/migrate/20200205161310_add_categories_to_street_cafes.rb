class AddCategoriesToStreetCafes < ActiveRecord::Migration[6.0]
  def change
    add_column :street_cafes, :category, :varchar
  end
end
