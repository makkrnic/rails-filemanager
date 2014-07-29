module RailsFilemanager
  class FilemanagerFile < ActiveRecord::Base

    has_attached_file :file

    has_ancestry


    #validates :choir_id, uniqueness: true, if: -> { self.ancestry.nil? }
    #validates :name, presence: true, if: -> { self.file_file_name.nil? }
    #validates :file_file_name, presence: true, if: -> { self.name.nil? }
    do_not_validate_attachment_file_type :file
    
    
    #validate :total_size_within_limits, if: -> { self.choir_id.present? }

    scope :root_dir, -> { where ancestry: nil }

    scope :sort_named, -> { order 'name ASC, file_file_name ASC, updated_at ASC' }

    include Rails.application.routes.url_helpers

    def to_jq_upload
      {
        name: self.name || self.file_file_name,
        size: file_file_size,
        url: file.url(:original),
        delete_url: '',
        delete_type: 'DELETE',
        directory: file_file_name.nil?,
        id: id,
      }
    end

    def path_name
      '/' + self.ancestors.map{|a| a.name + '/'}.join
    end

    #def self.total_storage_used(choir)
    #  choir.media_manager_files.sum(:file_file_size)
    #end

    #def total_size_within_limits
    #  if choir_id.present? && file.size
    #    choir = Choir.find_by id: choir_id


    #    if (self.class.total_storage_used(choir) + file.size) >= choir.settings.file_storage_limit
    #      errors.add(:file, :too_big)
    #    end
    #  end
    #end
  end
end
