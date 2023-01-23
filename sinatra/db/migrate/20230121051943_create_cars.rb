class CreateCars < ActiveRecord::Migration[7.0]
  def up
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.decimal :price
      t.timestamps
    end
  end

  def down
    drop_table :cars
  end
end
