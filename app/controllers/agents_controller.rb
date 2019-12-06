class AgentsController < ApplicationController
  before_action :logged_in_agent, only: [:edit, :update, :destroy]
  before_action :correct_agent, only: [:edit, :update]
  before_action :admin_agent, only: :destroy

  def index
    @agents = Agent.all.page(params[:page]).per(20)
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)
    if @agent.save
      @agent.send_activation_email
      flash[:info] = "メールを確認し、アカウントを有効化してください"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @agent = Agent.find(params[:id])
  end

  def edit
  end

  def update
    if @agent.update(agent_params)
      flash[:success] = "編集が完了しました"
      redirect_to @agent
    else
      render 'edit'
    end
  end

  def destroy
    Agent.find(params[:id]).destroy
    flash[:success] = "ユーザーは削除されました"
    redirect_to agents_url
  end

  private
    def agent_params
      params.require(:agent).permit(:name, :email, :password, :password_confirmation,
                      :category, :address, :scale, :target_category, :target_audience)
    end

    def logged_in_agent
      unless agent_logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to agent_login_url
      end
    end

    def correct_agent
      @agent = Agent.find(params[:id])
      redirect_to root_url unless current_agent?(@agent)
    end

    def admin_agent
      redirect_to root_url unless current_agent.admin?
    end
end
