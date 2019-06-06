class Transaction < ApplicationRecord

    validates :amount, numericality: { other_than: 0 }
  
    after_create :set_transaction_type
    after_create :update_balance

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

    def update_balance
        account_from = self.get_account(self.from_account)
        account_to = self.get_account(self.to_account)

        account_to[0].update_attribute(:balance, account_to[0].balance + self.amount)
        account_from[0].update_attribute(:balance, account_from[0].balance - self.amount)
    end

end
