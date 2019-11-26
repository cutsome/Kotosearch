class AgentsController < ApplicationController
  def index
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)
    if @agent.save
      agent_log_in @agent
      flash[:success] = "ご登録ありがとうございます！"
      redirect_to @agent
    else
      render "new"
    end
  end

  def show
    @agent = Agent.find(params[:id])
  end

  private
    def agent_params
      params.require(:agent).permit(:name, :email, :password, :password_confirmation)
    end
end
