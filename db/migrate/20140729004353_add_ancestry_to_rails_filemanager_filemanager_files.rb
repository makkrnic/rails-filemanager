class AddAncestryToRailsFilemanagerFilemanagerFiles < ActiveRecord::Migration
  def change
    add_column :rails_filemanager_filemanager_files, :ancestry, :string
    add_index :rails_filemanager_filemanager_files, :ancestry
  end
end
