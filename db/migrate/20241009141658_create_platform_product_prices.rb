class CreatePlatformProductPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :platform_product_prices do |t|
      t.decimal :amount
      t.boolean :most_recent, null: false
      t.references :platform_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
