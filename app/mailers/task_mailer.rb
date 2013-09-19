class TaskMailer < ActionMailer::Base
  default from: "new.message@taskstar.com",
          to: Proc.new { User.pluck(:email) }

  def new_task(task)
    @task = task
    @team = task.team.name
    @title = task.title
    @body = task.body
    @complete_by = task.complete_by.strftime("%A %B %e, %Y")

    mail subject: "New Task from #{@team}"
  end
end
