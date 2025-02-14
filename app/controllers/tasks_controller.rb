class TasksController < ApplicationController
  def index
    @tasks = Task.order(:name)
  end
  
  def show
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path 
      return
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      redirect_to task_path(@task.id)
      return
    else
      render :new
      return
    end
  end
  
  def edit
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    end
  end
  
  def update
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
      
    elsif @task.update(task_params)
      redirect_to task_path
      return
    else
      render :edit
      return
    end
  end
  
  def destroy
    @task = Task.find_by(id: params[:id])
    
    @task.destroy if @task
    
    redirect_to root_path
  end
  
  def complete
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    else @task.update(completed: Time.now)      
      redirect_back(fallback_location: root_path)
      return
    end
  end
  
  def not_complete
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to root_path
      return
    else @task.update(completed: nil)
      redirect_back(fallback_location: root_path)
      return
    end
  end
  
  private
  
  def task_params
    return params.require(:task).permit(:name, :description, :completed)
  end
end
