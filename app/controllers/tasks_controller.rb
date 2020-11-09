class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    
    def index
      @tasks = Task.all
    end

    def show
    end
    
    def new
      @task = Task.new
    end
    
    def create
      @task = Task.new(task_params)
    
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
        params.require(:task).permit(:content,:Status)
    end
end