class FamiliesController < ApplicationController
  include AppHelpers::Cart
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  authorize_resource
  before_action :check_login, except: [:new, :create]
  

  def index
    @families = Family.all.alphabetical.paginate(:page => params[:page]).per_page(12)
  end

  def show
    @students = @family.students.alphabetical
    @registrations = @family.registrations.sort
  end

  def edit
  end

  def new
    @family = Family.new
  end


  def create
    @family = Family.new(family_params)
    @user = User.new(user_params)
    @user.role = "parent"
    if !@user.save
      @family.valid?
      render action: 'new'
    else
      @family.user_id = @user.id
      if @family.save
        if !logged_in?
          session[:user_id] = @user.id
          create_cart
          redirect_to dashboard_path
          flash[:notice] = "You have been signed up, #{@family.family_name}" 
        else 
          flash[:notice] = "Successfully created #{@family.family_name}."
          redirect_to family_path(@family)
        end
      else
        render action: 'new'
      end      
    end
  end

  def update
    family_params[:password] = @family.password
    family_params[:password_confirmation] = @family.password_confirmation
    if @family.update(family_params)
      @family.user.update(user_params)
      redirect_to family_path(@family), notice: "#{@family.parent_first_name} #{@family.family_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    if @family.destroy
      redirect_to families_url, notice: "Successfully removed #{@family.family_name}, #{@family.parent_first_name} from the PATS system."
    else
      render action: 'show'
    end
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :active, :username, :password, :password_confirmation, :email, :phone)
    end

    def user_params
      params.require(:family).permit(:username, :password, :password_confirmation, :role, :email, :phone, :active)
    end
end


