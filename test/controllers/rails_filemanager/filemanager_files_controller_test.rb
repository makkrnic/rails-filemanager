require 'test_helper'

module RailsFilemanager
  class FilemanagerFilesControllerTest < ActionController::TestCase
    setup do
      @filemanager_file = filemanager_files(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:filemanager_files)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create filemanager_file" do
      assert_difference('FilemanagerFile.count') do
        post :create, filemanager_file: { name: @filemanager_file.name, owner_id: @filemanager_file.owner_id, parent_directory_id: @filemanager_file.parent_directory_id }
      end

      assert_redirected_to filemanager_file_path(assigns(:filemanager_file))
    end

    test "should show filemanager_file" do
      get :show, id: @filemanager_file
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @filemanager_file
      assert_response :success
    end

    test "should update filemanager_file" do
      patch :update, id: @filemanager_file, filemanager_file: { name: @filemanager_file.name, owner_id: @filemanager_file.owner_id, parent_directory_id: @filemanager_file.parent_directory_id }
      assert_redirected_to filemanager_file_path(assigns(:filemanager_file))
    end

    test "should destroy filemanager_file" do
      assert_difference('FilemanagerFile.count', -1) do
        delete :destroy, id: @filemanager_file
      end

      assert_redirected_to filemanager_files_path
    end
  end
end
