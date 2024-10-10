class AddPriceToCandidates < ActiveRecord::Migration[7.0]
  def change
    add_column :candidates, :amount, :decimal
  end
end
