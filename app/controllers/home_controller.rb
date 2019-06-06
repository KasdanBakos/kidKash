class HomeController < ApplicationController
  # before_action :check_login, only: [:dashboard]
  def index
  end

  def about
  end

  def contact
  end

  def privacy 
  end

  def dashboard
    @my_accounts = current_user.get_accounts(current_user)
    #for parent
    if !current_user.nil? and current_user.role == "Parent"
      @your_children = current_user.find_children.to_a

    # elsif !current_user.nil? and current_user.role == "Child"
      #display your accounts
      
    end

    #for child


  end
  
end