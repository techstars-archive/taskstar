class TasksController < ApplicationController
  before_filter :find_task, only: [:show, :edit, :update, :destroy]
  before_filter :get_teams, only: [:new, :create, :edit, :update]
  def index
    @tasks = Task.includes(:team).where(status: nil).order("created_at DESC")
    @in_progress = Task.in_progress.order("created_at DESC")
  end

  def done
    @done = Task.done
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "new task"
      redirect_to root_path
    else
      flash[:alert] = "new task failed"
      render "new"
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      flash[:notice] = "task updated"
      redirect_to root_path
    else
      flash[:alert] = "task update failed"
      render "edit"
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "task deleted"
    redirect_to root_path
  end

  def set_as_in_progress
    @task = Task.find(params[:id])
    @task.status = "In Progress"
    @task.user = current_user
    if @task.save
      flash[:notice] = "task set as in progress"
      redirect_to root_path
    else
      flash[:alert] = "task update failed"
      render "show"
    end
  end

  def set_as_done
    @task = Task.find(params[:id])
    @task.status = "Done"
    if @task.save
      flash[:notice] = "task set as done"
      redirect_to root_path
    else
      flash[:alert] = "task update failed"
      render "show"
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :body, :complete_by, :team_id, :status)
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def get_teams
    @teams = Team.all
  end
end
