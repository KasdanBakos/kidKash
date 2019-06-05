class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource
  before_action :check_login, except: [:new]
  

  def index
    # if current_user.role?(:admin)
    @users = User.all.alphabetical.paginate(:page => params[:page]).per_page(10)
    # end
  end

  def show
    if current_user.role?(:parent)
      @users_students = current_user.family.students.alphabetical
    elsif current_user.role?(:instructor)
      @users_camps = current_user.instructor.camps.chronological
    end
  end

  def edit
    @user.role = "parent" if current_user.role?(:family)
    @user.role = "instructor" if current_user.role?(:instructor)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if (current_user.role?(:admin) and @user.role.nil?)
      @user.role = "admin" 
    end
    if @user.save
      redirect_to user_path(@user), notice: "#{@user.username} user was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.username} user was revised in the system."
      redirect_to user_path(@user) 
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "#{@user.username} user was removed from the system."
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :role, :email, :phone, :active)
    end
end