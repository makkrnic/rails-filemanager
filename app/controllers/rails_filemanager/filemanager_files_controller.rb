require_dependency "rails_filemanager/application_controller"


module RailsFilemanager
  class FilemanagerFilesController < ApplicationController

    append_before_action :load_current_owner
    append_before_action :check_privileges

    def index
      respond_to do |format|

        format.html
        format.json do


          # if params[:dir_id].present? && params[:dir_id] != '0'
          #   @directory = MediaManagerFile.find_by id: params[:dir_id]
          # else
          #   @directory = @choir.media_manager_files.root_dir.first
          #   unless @directory
          #     @directory = @choir.media_manager_files.create name: @choir.name
          #   end
          # end
          #
          if params[:dir_id].present? && params[:dir_id] != '0'
            @directory = FilemanagerFile.find_by id: params[:dir_id]
          else
            @directory = @current_owner.rails_filemanager_files.root_dir.first
            unless @directory
              @directory = @current_owner.rails_filemanager_files.create name: 'root'
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
      file_params = filemanager_file_params
      file_params['parent_id'] = @current_owner.rails_filemanager_files.first.id if file_params['parent_id'].to_i == 0 || file_params['parent_id'].blank?
      #file_params.delete_if{|k, v| k == 'parent_id' && (v.to_i == 0 || v.blank?) }
      logger.debug file_params.inspect
      @upload = FilemanagerFile.new file_params
      @upload.owner = @current_owner

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
      render json: { storage_free: (@current_owner.send(owner.class.storage_limit_method) - @current_owner.total_storage_used) }
    end

    def destroy
      @file = FilemanagerFile.find_by id: params[:id]
      
      if @file == nil
        head :not_found
      elsif @file.destroy
        head :ok
      else
        head :internal_server_error
      end
    end

    private

      def filemanager_file_params
        params.require(:filemanager_file).permit :file, :name, :parent_id
      end

      def check_privileges
        #unless current_user.can? :upload_files, @choir
        #  flash[:error] = I18n.t 'general.invalid_permissions'
        #  redirect_to root_url(@choir)
        #end

        if self.respond_to?(:user_can_manage_files?)
          unless user_can_manage_files?
            render 'authorization_failure'
          end
        else
          warn "WARNING: `user_can_manage_files?` method not present. Allowing file managing"
        end

      end

      def load_current_owner
        #@current_owner = self.send(self.current_owner_method)
        @current_owner = self.current_owner
      end
  end
end
