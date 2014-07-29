module OwnersHelper

  def current_owner
    klass = params[:owner_type].classify.constantize.find_by params[:owner_id]
  end
end
