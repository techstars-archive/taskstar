class TasksController < ApplicationController
  before_filter :find_task, only: [:show, :edit, :update, :destroy]
  before_filter :get_teams, only: [:new, :create, :edit, :update]
  def index
    @tasks = Task.includes(:team).where(status: nil).order("created_at DESC")
    @in_progress = Task.includes(:team, :user).in_progress.order("created_at DESC")
  end

  def done
    @done = Task.includes(:team, :user).done.order("updated_at DESC")
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "A new task has been added."
      TaskMailer.new_task(@task).deliver
      redirect_to root_path
    else
      flash[:alert] = "There was a problem adding a new task."
      render "new"
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      flash[:notice] = "The task has been updated."
      redirect_to root_path
    else
      flash[:alert] = "There was a problem updating the task."
      render "edit"
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "The task has been deleted."
    redirect_to root_path
  end

  def set_as_in_progress
    @task = Task.find(params[:id])
    @task.status = "In Progress"
    @task.user = current_user
    if @task.save
      flash[:notice] = "The task has been set as in progress."
      redirect_to root_path
    else
      flash[:alert] = "There was a problem setting the status of the task."
      render "show"
    end
  end

  def set_as_done
    @task = Task.find(params[:id])
    @task.status = "Done"
    @task.user ||= current_user
    if @task.save
      flash[:notice] = "The task has been set as done."
      redirect_to root_path
    else
      flash[:alert] = "There was a problem setting the status of the task."
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
