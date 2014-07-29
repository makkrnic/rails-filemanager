class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_owner
    Owner.find_by params[:owner_id]
  end

  protected

    def current_owner_method
      :current_owner
    end
end
