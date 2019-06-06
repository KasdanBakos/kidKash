class Transaction < ApplicationRecord

    validates :amount, numericality: { other_than: 0 }
  
    after_create :set_transaction_type

    # make callback to set transaction type
    def set_transaction_type
        if(self.amount > 0)
            self.update_attribute(:trans_type, "Deposit")
        elsif(self.amount < 0)
            self.update_attribute(:trans_type, "Withdrawal")
        end
    end


    def get_account(num)
        Account.all.select{ |a| a.id == num}
    end

    # make callback to update balance
    #TODO

end
