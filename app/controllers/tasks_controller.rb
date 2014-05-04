class TasksController < ApplicationController
   def new
      @task = Task.new
   end
   
   def index
      @tasks = Task.all
   end

   def create
      @task = Task.new(task_params)

      if @task.save
          redirect_to @task
          @users = User.all
          @users.each do |t|
             Unit.create email: t.email, homework: @task.homework, number: @task.number
          end
      else
          render 'new'
      end
   end

   def edit
      @task = Task.find(params[:id])
   end

   def destroy
       @task = Task.find(params[:id])
       Unit.where(number: @task.number, homework: @task.homework).delete_all
       @task.destroy

       redirect_to tasks_path
   end

   def update
       @task = Task.find(params[:id])
 
       if @task.update(task_params)
           redirect_to @task
       else
           render 'edit'
       end
   end

   private
      def task_params
          params.require(:task).permit(:number, :homework, :condition, :time)
      end
end
