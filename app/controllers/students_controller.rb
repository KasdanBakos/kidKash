 class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  authorize_resource
  before_action :check_login
  

  def index
    @students = Student.all.alphabetical.paginate(:page => params[:page]).per_page(12)
    if current_user.role?(:instructor)
      #how to paginate?
      @camp_students = Student.all.alphabetical.select{|s| (s.registrations.map{|r| r.camp.instructors}.flatten).include?(current_user.instructor)}
    elsif current_user.role?(:parent)
      @family_students = Student.all.select{|s| s.family == current_user.family}
    end
    
  end

  def show
    @past_camps = @student.camps.past.chronological
    @upcoming_camps = @student.camps.upcoming.chronological
    @registrations = @student.registrations
  end

  def edit
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to student_path(@student), notice: "#{@student.first_name} #{@student.last_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @student.update(student_params)
      redirect_to student_path(@student), notice: "#{@student.first_name} #{@student.last_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: "#{@student.first_name} #{@student.last_name} was deleted from the system."
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end
end