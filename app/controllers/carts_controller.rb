class CartsController < ApplicationController
    include AppHelpers::Cart
    before_action :check_login

    def index
        # @cart = get_array_of_ids_for_generating_registrations
        @cart = session[:cart]
        @total_cost = calculate_total_cart_registration_cost
        
    end

    def show
        @cart = session[:cart]
    end

    def edit
    end

    def update
    end

    def destroy
    end

    def add_to_cart
      add_registration_to_cart((params[:registration][:camp_id]), (params[:registration][:student_id]))
      redirect_to show_cart_path, alert: "Camp Added to your cart!"
    end

    def remove_from_cart
      @cart = session[:cart]
      @camp = Camp.find(params[:camp_id])
      @student = Student.find(params[:student_id])
      @cart.each do |ci|
        if ci["ids"] == [@camp.id.to_s, @student.id.to_s]
          session[:cart].delete(ci)
        end
      end
      # remove_registration_from_cart(@camp.id, @student.id)
      redirect_to show_cart_path, alert: "Removed #{@camp.name} from your cart!"
    end

    def empty_cart
      clear_cart
      redirect_to show_cart_path, alert: "Cart has been emptied"
    end

    def checkout
      @credit_card = CreditCard.new(params[:registration][:credit_card_number], params[:registration][:expiration_year], params[:registration][:expiration_month])
      # generate_payment_receipt
      if @credit_card.valid?
        @regs = get_array_of_ids_for_generating_registrations
        @regs.each do |reg|
          newReg = Registration.new(:camp_id => reg[0], :student_id => reg[1])
          newReg.credit_card_number = params[:registration][:credit_card_number]
          newReg.expiration_year = params[:registration][:expiration_year].to_i
          newReg.expiration_month = params[:registration][:expiration_month].to_i
          if newReg.valid?
            newReg.save
            newReg.pay
          end
          newReg.save!
        end
        clear_cart
        redirect_to user_path(current_user), alert: "Registered for camps"
      end
    end

    private
    def card_params
      params.require(:registration).permit(:camp_id, :student_id)
    end

end
