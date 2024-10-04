class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :url
      t.string :image_url
      t.string :title
      t.references :platform_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
