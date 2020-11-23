class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy, :show]
    
    def index
        @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end

    def show
    end
    
    def new
      @task = Task.new
    end
    
    def create
      @task = current_user.tasks.build(task_params)
    
      if @task.save
        flash[:success] = 'Task の追加が完了しました'
        redirect_to @task
      else
        flash.now[:danger] = 'Task が追加されませんでした'
        render :new
      end
    end
    
    def edit
    end
    
    def update
        
      if @task.update(task_params)
        flash[:success] = 'Task の更新が行われました。'
            redirect_to @task
      else
        flash.now[:danger] = 'Task は更新されませんでした。'
        render :edit
      end
    end
    
    def destroy
      @task.destroy
        
      flash[:success] = 'Task の削除が完了しました。'
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content,:status)
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task 
        redirect_to root_path
      end
    end
end