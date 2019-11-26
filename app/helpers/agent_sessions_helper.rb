module AgentSessionsHelper

  def agent_log_in(agent)
    session[:agent_id] = agent.id
  end

  def current_agent
    if session[:agent_id]
      @current_agent ||= Agent.find_by(id: session[:agent_id])
    end
  end

  def agent_logged_in?
    !current_agent.nil?
  end

  def agent_log_out
    session.delete(:agent_id)
    @current_agent = nil
  end
end
