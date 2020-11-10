class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
      @task = current_user.tasks.build  # form_with用
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end
  
  def show
     @task = Task.find(params[:id])
  end
  
  def edit
     @task = Task.find(params[:id])
  end
  
  def update
     @task = Task.find(params[:id])
     @task.attributes = task_params
     if @task.save
      flash[:success] = 'タスクを正常に更新しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの更新に失敗しました。'
      render 'tasks/index'
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを作成しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの作成に失敗しました。'
      render action: :index
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    redirect_to tasks_path
  end

  private

  def task_params
    
    params.require(:task).permit(:status,:content)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end