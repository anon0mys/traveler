class RemoveStateFromLocations < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :state, :string
  end
end
