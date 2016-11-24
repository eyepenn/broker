class AlterPropertiesAddImagesColumn < ActiveRecord::Migration
  def change
  	add_column :properties, :images, :integer
  	add_column :properties, :images_folder, :string
  end
end
