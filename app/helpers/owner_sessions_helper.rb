module OwnerSessionsHelper

  def owner_log_in(owner)
    session[:owner_id] = owner.id
  end

  def owner_remember(owner)
    owner.owner_remember
    cookies.permanent.signed[:owner_id] = owner.id
    cookies.permanent[:remember_token] = owner.remember_token
  end

  def current_owner
    if (owner_id = session[:owner_id])
      @current_owner ||= Owner.find_by(id: owner_id)
    elsif (owner_id = cookies.signed[:owner_id])
      owner = Owner.find_by(id: owner_id)
      if owner && owner.authenticated?(cookies[:remember_token])
        owner_log_in owner
        @current_owner = owner
      end
    end
  end

  def owner_logged_in?
    !current_owner.nil?
  end

  def forget(owner)
    owner.forget
    cookies.delete(:owner_id)
    cookies.delete(:remember_token)
  end

  def owner_log_out
    forget(current_owner)
    session.delete(:owner_id)
    @current_owner = nil
  end
end
