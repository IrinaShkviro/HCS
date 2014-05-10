class UsersController < ApplicationController
  def index
    @users = User.all
    @users30 = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @datafile = Datafile.new
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
     if (signed_in? and (current_user.admin? or current.user.id == @user.id))

	    if @user.update_attributes(user_params)
	      flash[:success] = "Profile updated"
	      redirect_to users_path
	    else
	      render 'edit'
	    end
     end
  end

  def create
        if signed_in? and current_user.admin?
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "User has been created successfully"
			redirect_to users_path
		        Dir.mkdir("#{Dir.pwd}/public/uploads/#{@user.email}")
		        @units = Unit.all
		        @tasks = Task.all
		        @tasks.each do |t|
		             Unit.create email: @user.email, homework: t.homework, number: t.number
		        end
		else
			render 'new'
		end
        end
  end

  def destroy
      if signed_in? and current_user.admin?
	  @user = User.find(params[:id])
          Unit.where(email: @user.email).delete_all
          @user.destroy
	  flash[:success] = "User deleted."
	  redirect_to users_url
          FileUtils.remove_dir "#{Dir.pwd}/public/uploads/#{@user.email}", true
      end
  end

  private

	def user_params
		params.require(:user).permit(:name, :surname,  :patronymic, :phone, :group, :email, :password, :password_confirmation, :admin)
	end

	# Before filters

       	def signed_in_user
     	  unless signed_in?
        	store_location
        	redirect_to signin_url, notice: "Please sign in."
      	  end
     	end

	def correct_user
     		@user = User.find(params[:id])
     		redirect_to(root_url) unless current_user?(@user)
   	end

	def admin_user
      		redirect_to(root_url) unless current_user.admin?
    	end
end

