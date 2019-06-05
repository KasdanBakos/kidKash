class Ability
  include CanCan::Ability

  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
      can :manage, Registration #redundant but oh well
      


    elsif user.role? :instructor
      # can read curriculums, locations, and camps
      can :read, Curriculum
      can :read, Location
      can :read, Camp

      # they can edit their own profile
      can :edit, Instructor do |i|  
          i.user_id == user.id
        end
      can :update, Instructor do |i|  
        i.user_id == user.id
      end
      can :show, Instructor do |i|  
        i.user_id == user.id
      end
      can :update, User do |u|  
        u.id == user.id
      end
      can :edit, User do |u|  
        u.id == user.id
      end

      can :show, User do |u|  
        u.id == user.id
      end

      can :index, Student
      #because i overwrote the students index page for instructors.



      can :show, Student do |s|
        my_camps = user.instructor.camps.map{|c| c.id}
        students_camps = s.registrations.map{|r| r.camp_id}
        found = false
        students_camps.each do |camp|
          if (my_camps.include?(camp)) then found = true
          end
        end
        found
      end

      can :show, Family do |f|
        my_camps = user.instructor.camps.map{|c| c.id}
        family_students_camps = f.students.map{|s| s.registrations}.flatten.map{|r| r.camp.id}
        found = false
        family_students_camps.each do |c|
          if (my_camps.include?(c)) then found = true
          end
        end
        found
      end



    elsif user.role? :parent
      can :read, Curriculum
      can :read, Location
      can :read, Camp
      can :read, Instructor
      can :students, Camp
      can :instructors, Camp
      can :create, Registration
      can :new, Registration


      # they can read their own data
      can :show, Family do |this_family|
        user.id == this_family.user_id
      end

      can :edit, Family do |this_family|
        user.id == this_family.user_id      
      end

      can :update, Family do |this_family|
        user.id == this_family.user_id      
      end

      can :show, User do |this_user|
        # puts "in the family"
        user.id == this_user.id
      end

      can :edit, User do |this_user|
        user.id == this_user.id      
      end  

      can :update, User do |this_user|
        user.id == this_user.id      
      end        


      # Can manage students associated with family
      can :manage, Student do |s|
        user.id == s.family.user_id
      end

      # can manage registrations for students in family but not edit or remove once payment is made
      can :manage, Registration do |r|
        if(user.family != nil)
          user.family.registrations.include?(r) and r.payment == nil
        end
      end

      can :index, Student do |s|
        #can see the student if they are in the same camp as their registrations (on camp details page)
        if(user.family != nil)
          users_students_registrations = user.family.students.map{|stud| stud.registrations}.flatten
          s.registrations.each do |r|
            users_students_registrations.include?(r)
          end
        end
      end

      
      
    else
      can :read, Curriculum
      can :read, Location
      can :read, Camp

      can :create, User
      can :create, Family

    end
  end
end
