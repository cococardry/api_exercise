class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
           t.string :juhe_id
           t.string :province
           t.string :city
           t.string :district
           t.string :current_temp
           t.string :wind_direction
           t.string :wind_strength
      t.timestamps
    end
    add_index :cities, :juhe_id
  end
end
