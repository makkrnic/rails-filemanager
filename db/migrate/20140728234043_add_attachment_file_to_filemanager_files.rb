include Paperclip::Schema
class AddAttachmentFileToFilemanagerFiles < ActiveRecord::Migration
  def self.up
    add_attachment :rails_filemanager_filemanager_files, :file
  end

  def self.down
    remove_attachment :rails_filemanager_filemanager_files, :file
  end
end
