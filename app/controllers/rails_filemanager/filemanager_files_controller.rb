require_dependency "rails_filemanager/application_controller"

module RailsFilemanager
  class FilemanagerFilesController < ApplicationController

    def index
      respond_to do |format|

        format.html
        format.json do

          if params[:dir_id].present? && params[:dir_id] != '0'
            @directory = FilemanagerFile.find_by id: params[:dir_id]
          else
            @directory = FilemanagerFile.root_dir.first
            unless @directory
              @directory = FilemanagerFile.create name: 'root'
            end
          end

          logger.debug @directory.inspect
          logger.debug @directory.children.inspect

          @uploads = @directory.children.sort_named

          render json: { directory_name: @directory.name, files: @uploads.map{|upload| upload.to_jq_upload } }
        end
      end
    end

    def create
      file_params = media_manager_file_params
      file_params['parent_id'] = FilemanagerFile.first.id if file_params['parent_id'].to_i == 0 || file_params['parent_id'].blank?
      #file_params.delete_if{|k, v| k == 'parent_id' && (v.to_i == 0 || v.blank?) }
      logger.debug file_params.inspect
      @upload = FilemanagerFile.new file_params
      #@upload.choir = @choir

      respond_to do |format|
        if @upload.save
          format.html {
            render json: [@upload.to_jq_upload].to_json,
            content_type: 'text/html',
            layout: false
          }
          format.json { render json: { files: [@upload.to_jq_upload]}, status: :created}
        else
          format.html { render action: 'new' }
          format.json { render json: { status: 'ERROR', errors: @upload.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end

    def storage_free
      choir = Choir.find_by id: params[:choir_id] if params[:choir_id]
      choir = Choir.find_by slug: params[:choir] if params[:choir]
      render json: { storage_free: (choir.settings.file_storage_limit - MediaManagerFile.total_storage_used(choir)) }
    end

    def destroy
      @file = MediaManagerFile.find_by id: params[:id]
      
      if @file == nil
        head :not_found
      elsif @file.destroy
        head :ok
      else
        head :internal_server_error
      end
    end

    private

      def media_manager_file_params
        params.require(:filemanager_file).permit :file, :name, :parent_id
      end

      def check_privileges
        unless current_user.can? :upload_files, @choir
          flash[:error] = I18n.t 'general.invalid_permissions'
          redirect_to root_url(@choir)
        end
      end
  end
end
