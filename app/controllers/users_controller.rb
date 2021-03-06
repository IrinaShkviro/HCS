class UsersController < ApplicationController
   before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
   before_action :correct_user,   only: [:edit, :update]
   before_action :admin_user,     only: :destroy

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

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
	@user = User.new(user_params)
	if @user.save
		flash[:success] = "User has been created successfully"
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

  def destroy
	  @user = User.find(params[:id])
          Unit.where(email: @user.email).delete_all
          @user.destroy
	  flash[:success] = "User deleted."
	  redirect_to users_url
          Dir.rmdir("#{Dir.pwd}/public/uploads/ #{@user.email}")
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

