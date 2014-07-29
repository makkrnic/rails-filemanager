class CreateRailsFilemanagerFilemanagerFiles < ActiveRecord::Migration
  def change
    create_table :rails_filemanager_filemanager_files do |t|
      t.string :name
      t.integer :parent_directory_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
