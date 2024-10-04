class CreatePlatformProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :platform_products do |t|
      t.string :url
      t.string :image_url
      t.string :title
      t.references :product, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
