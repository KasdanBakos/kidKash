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
    if !current_user.nil?
      @my_accounts = current_user.get_accounts(current_user)
    end
    
    #for parent
    if !current_user.nil? and current_user.role == "Parent"
      @your_children_accounts = current_user.get_children_accounts
    end
  end
  
end