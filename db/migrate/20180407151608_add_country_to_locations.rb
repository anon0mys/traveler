class AddCountryToLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :country
    add_reference :locations, :country, index: true
  end
end
