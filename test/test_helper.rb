ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # OLD: parallelize(workers: :number_of_processors)  <--
  parallelize(workers: 1) # i.e don't run tests in parallel via forked processes
  # OR just comment the line above out completely <--

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def is_logged_in?
    !session[:agent_id].nil? || !session[:owner_id].nil?
  end

  def agent_login(agent)
    session[:agent_id] = agent.id
  end

  def owner_login(owner)
    session[:owner_id] = owner.id
  end

  class ActionDispatch::IntegrationTest

    def agent_login(agent, password:'1234abcd', remember_me: '1')
      post agent_login_path, params: { session: { email: agent.email,
                         password: password, remember_me: remember_me } }
    end

    def owner_login(owner, password:'1234abcd', remember_me: '1')
      post owner_login_path, params: { session: { email: owner.email,
                         password: password, remember_me: remember_me } }
    end
  end
end
