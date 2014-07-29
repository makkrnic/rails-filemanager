module RailsFilemanager
  class FilemanagerFile < ActiveRecord::Base

    has_attached_file :file

    has_ancestry

    belongs_to :owner, polymorphic: true

    #validates :choir_id, uniqueness: true, if: -> { self.ancestry.nil? }
    validates :name, presence: true, if: -> { self.file_file_name.nil? }
    validates :file_file_name, presence: true, if: -> { self.name.nil? }
    do_not_validate_attachment_file_type :file
    
    
    validate :total_size_within_limits, if: -> { self.owner_id.present? }

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

    def total_size_within_limits
      if self.owner.present? && file.size

        if (self.owner.total_storage_used + file.size) >= owner.send(owner.class.storage_limit_method)
          errors.add(:file, :too_big)
        end
      end
    end
  end
end
