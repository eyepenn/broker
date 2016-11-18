class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :active
      t.string :status
      t.string :neighborhood
      t.integer :price
      t.string :address

      t.timestamps
    end
  end
end
