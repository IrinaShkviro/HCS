class IndexController < ApplicationController

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

end
