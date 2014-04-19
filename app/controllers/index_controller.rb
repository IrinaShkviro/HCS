class IndexController < ApplicationController

	def home
	  @users = User.all
       	  @tasks = Task.all
       	  @datafile = Datafile.new
	end

	def about
	end

	def help
	end

	def contact
	end


end
