class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :currency_name
      t.string :unit
      t.float :spot_buying_rate
      t.float :cash_buying_rate
      t.float :cash_selling_rate
      t.timestamps
    end
  end
end
