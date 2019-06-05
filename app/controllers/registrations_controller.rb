class RegistrationsController < ApplicationController
  include AppHelpers::Cart
  
  def new    
    @registration   = Registration.new
    # @camp              = Camp.find(params[:camp_id])
    # @other_instructors = @camp.instructors
  end
  
  def create
    @payment = CreditCard.new
    @registration = Registration.new(registration_params)
    if @registration.save
      flash[:notice] = "Successfully registered student."
      redirect_to camp_path(@registration.camp)
    else
      @camp = Camp.find(params[:registration][:camp_id])
      @other_students = @camp.students
      # flash[:errors] = "Cant work"
      # render action: 'show', locals: { camp: @camp, other_students: @other_students }
    end
  end
 
  def destroy
    # @registration = Registration.find(params[:id])
    camp_id = params[:id]
    student_id = params[:student_id]
    @registration = Registration.where(camp_id: camp_id, student_id: student_id).first
    unless @registration.nil?  #is this the right place for this?
      @registration.destroy
      flash[:notice] = "Successfully removed this student."
    end
  end

  private
    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment)
    end

end