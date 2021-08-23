class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_url
      t.string :description
      t.string :alcohol
      t.timestamps
    end
  end
end
