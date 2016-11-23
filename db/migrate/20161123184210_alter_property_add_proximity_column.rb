class AlterPropertyAddProximityColumn < ActiveRecord::Migration
  def change
  	add_column :properties, :proximity, :string
  	add_column :properties, :description, :text
  	add_column :properties, :doorman, :string
  	add_column :properties, :outdoor, :string
  	add_column :properties, :notes, :string
  	add_column :properties, :property_type, :string
  	add_column :properties, :bed, :integer
  	add_column :properties, :bath, :integer
  	add_column :properties, :maintenance, :integer
  end
end
