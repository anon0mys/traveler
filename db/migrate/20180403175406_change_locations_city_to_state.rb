class ChangeLocationsCityToState < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :city
    add_column :locations, :state, :string
  end
end
