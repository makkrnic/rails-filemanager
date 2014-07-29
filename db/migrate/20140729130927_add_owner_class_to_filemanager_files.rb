class AddOwnerClassToFilemanagerFiles < ActiveRecord::Migration
  def change
    add_column :rails_filemanager_filemanager_files, :owner_type, :string
  end
end
