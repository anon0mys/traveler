class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :code
      t.float :lat
      t.float :lng
      t.string :name

      t.timestamps
    end
  end
end
