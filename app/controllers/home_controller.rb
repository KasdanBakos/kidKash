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
    #for parent
    if !current_user.nil? and current_user.role == "Parent"
      @your_children = current_user.find_children

    elsif !current_user.nil? and current_user.role == "Child"
      #display your accounts
      @my_accounts = current_user.accounts
    end

    #for child


  end
  
end