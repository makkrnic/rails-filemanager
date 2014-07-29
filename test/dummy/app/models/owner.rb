class Owner < ActiveRecord::Base
  include RailsFilemanager::ActsAsFilemanagerOwner
  

  acts_as_filemanager_owner storage_limit_method: :storage_limit
  
  #after_initialize do
  #  test1
  #end
  
  def storage_limit
    self.max_total_file_size
  end
end
