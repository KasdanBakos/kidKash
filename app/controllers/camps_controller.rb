class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy, :instructors, :students]
  authorize_resource

  def index
    @active_camps = Camp.all.active.alphabetical.paginate(:page => params[:active_camps]).per_page(10)
    @inactive_camps = Camp.all.inactive.alphabetical.paginate(:page => params[:inactive_camps]).per_page(1)
  end

  def show
    #lists the instructors and students connected to camp
    @instructors = @camp.instructors.alphabetical
    @students = @camp.students.alphabetical
    
    if !current_user.nil?
      #these are for the dropdowns for adding instructor or students for admin
      if current_user.role?(:admin)
        @available_instructors = (Instructor.all.active.alphabetical - @instructors).select{|i| i.available(@camp)}
        @eligible_students = (Student.all.active.alphabetical - @students).select{|s| s.eligible(@camp,s)}
        @students_in_cart_conflicting = session[:cart].select{|i| i["ids"][0].to_i == @camp.id}
        @students_in_cart_conflicting = @students_in_cart_conflicting.map{|i| Student.find(i["ids"][1].to_i)}
        @eligible_students = @eligible_students - @students_in_cart_conflicting

        
      #these are for the dropdowns for adding students for parents
      elsif(current_user.role?(:parent))
        @parent_eligible_students = (Student.all.alphabetical.select{|s| current_user.family.students.include?(s)} - @students).select{|s| s.eligible(@camp,s)}
        @students_in_cart_conflicting = session[:cart].select{|i| i["ids"][0].to_i == @camp.id}
        @students_in_cart_conflicting = @students_in_cart_conflicting.map{|i| Student.find(i["ids"][1].to_i)}
        @parent_eligible_students = @parent_eligible_students - @students_in_cart_conflicting
      end
    end
  end

  def edit
  end

  def new
    @camp = Camp.new
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to camp_path(@camp), notice: "#{@camp.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    @camp.update(camp_params)
    if @camp.save
      redirect_to camp_path(@camp), notice: "#{@camp.name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @camp.destroy
    redirect_to camps_url, notice: "#{@camp.name} was removed from the system."
  end

  def instructors
    @instructors = Instructor.for_camp(@camp).alphabetical
  end

  def students
    @students = Student.for_camp(@camp)
  end

  def registrations
    @cart = session[:cart]
  end

  private
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active)
    end
end