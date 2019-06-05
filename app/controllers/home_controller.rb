class HomeController < ApplicationController
  before_action :check_login, only: [:dashboard]
  def index
  end

  def about
  end

  def contact
  end

  def privacy 
  end

  def dashboard


    #all for admin
    @num_camps = Camp.all.to_a.count
    @num_currs = Curriculum.all.to_a.count
    @num_instructors = Instructor.all.to_a.count
    @num_students = Student.all.to_a.count
    @num_locations = Location.all.to_a.count
    @num_families = Family.all.to_a.count
    @camps_without_instructors = Camp.all.active.chronological.select{|c| c.instructors.count == 0}
    @camps_without_instructors_count = Camp.all.active.chronological.select{|c| c.instructors.count == 0}.count
    @top_3_students = Student.all.ranking.limit(3)

    #all for parent
    if !current_user.nil? and current_user.role?(:parent)
      @your_students = current_user.family.students.alphabetical
      @upcoming_regs = current_user.family.students.map{|s| s.registrations}.flatten!
      @total_spent = current_user.family.students.map{|s| s.registrations}.flatten.map{|r| r.camp.cost}.sum

    elsif !current_user.nil? and current_user.role?(:instructor)
      @number_of_students = current_user.instructor.camps.map{|c| c.enrollment}.sum
      @upcoming_camps = current_user.instructor.camps.upcoming
    end
  end
  
end