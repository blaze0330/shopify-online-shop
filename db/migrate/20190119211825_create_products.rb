class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, default: ""
      t.decimal :price, default: 0.0
      t.integer :inventory_count, default: 0

      t.timestamps
    end
  end
end
