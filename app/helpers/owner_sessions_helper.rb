module OwnerSessionsHelper

  def owner_log_in(owner)
    session[:owner_id] = owner.id
  end

  def current_owner
    if session[:owner_id]
      @current_owner ||= Owner.find_by(id: session[:owner_id])
    end
  end

  def owner_logged_in?
    !current_owner.nil?
  end

  def owner_log_out
    session.delete(:owner_id)
    @current_owner = nil
  end
end
