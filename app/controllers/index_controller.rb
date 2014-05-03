class IndexController < ApplicationController
        helper_method :taskCountInHometask
        helper_method :hometasksArray
	def home
	  @users = User.where(admin: false)
       	  @tasks = Task.all
       	  @datafile = Datafile.new
          @unit = Unit.new
	end

	def about
	end

	def help
	end

	def contact
	end

        def managment

        end

        def self.taskCountInHometask(searched_homework)
           return Task.where(homework: searched_homework).count
        end

        def self.hometasksArray
           @tasks2 = Task.all
           array = []
           @tasks2.each do |t|
               if !array.include?(t.homework)
                   array.push(t.homework)
               end
           end
           return array.sort
        end

end
