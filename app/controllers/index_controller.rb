class IndexController < ApplicationController
        helper_method :taskCountInHometask
        helper_method :hometaskCount
	def home
	  @users = User.all
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

        def self.hometaskCount
           @tasks2 = Task.all
           array = [2]
           @tasks2.each do |t|
               if !array.include?(t.homework)
                   array.push(t.homework)
               end
           end
           return array.length
        end

end
