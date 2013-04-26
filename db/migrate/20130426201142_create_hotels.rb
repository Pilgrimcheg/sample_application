class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :title
      t.text :room_description
      t.boolean :include_breakfast
      t.float :price
      t.string :adress
      t.integer :user_id

      t.timestamps
    end
    add_index :hotels, [:user_id, :created_at]
  end
end
