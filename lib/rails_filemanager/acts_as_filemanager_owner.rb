module RailsFilemanager
  module ActsAsFilemanagerOwner
    extend ActiveSupport::Concern

    included do

      has_many :rails_filemanager_files, foreign_key: :owner_id, class_name: 'RailsFilemanager::FilemanagerFile', as: :owner

      cattr_accessor :storage_limit_method
    end

    module ClassMethods
      def acts_as_filemanager_owner(options = {})
        raise "Storage limit method not set!" unless options[:storage_limit_method].present?
        self.storage_limit_method = options[:storage_limit_method]

        include RailsFilemanager::ActsAsFilemanagerOwner::InstanceMethods
      end
    end

    module InstanceMethods
      def total_storage_used
        self.rails_filemanager_files.sum(:file_file_size)
      end
    end
  end
end

#ActiveRecord::Base.send :include, RailsFilemanager::ActsAsFilemanagerOwner
