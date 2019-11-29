module AgentSessionsHelper

  def agent_log_in(agent)
    session[:agent_id] = agent.id
  end

  def agent_remember(agent)
    agent.agent_remember
    cookies.permanent.signed[:agent_id] = agent.id
    cookies.permanent[:remember_token] = agent.remember_token
  end

  def current_agent
    if (agent_id = session[:agent_id])
      @current_agent ||= Agent.find_by(id: agent_id)
    elsif (agent_id = cookies.signed[:agent_id])
      agent = Agent.find_by(id: agent_id)
      if agent && agent.authenticated?(cookies[:remember_token])
        agent_log_in agent
        @current_agent = agent
      end
    end
  end

  def current_agent?(agent)
    agent == current_agent
  end

  def agent_logged_in?
    !current_agent.nil?
  end

  def forget(agent)
    agent.forget
    cookies.delete(:agent_id)
    cookies.delete(:remember_token)
  end

  def agent_log_out
    forget(current_agent)
    session.delete(:agent_id)
    @current_agent = nil
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def redirect_back_or(default)
    redirect_to session[:forwarding_url] || default
    session.delete(:forwarding_url)
  end
end
