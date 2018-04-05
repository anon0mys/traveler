class ChangeLongInLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :long
    add_column :locations, :lng, :float
  end
end
