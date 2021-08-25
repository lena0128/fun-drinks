class CreateDrinks < ActiveRecord::Migration[6.1]
  def change
    create_table :drinks do |t|
      t.string :drink_name
      t.string :drink_thumb
      t.integer :item_id
      t.integer :user_id
      t.timestamps
    end
  end
end
