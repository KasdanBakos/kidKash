class User < ApplicationRecord
    has_many :parent_children
    has_secure_password
    mount_uploader :photo, PhotoUploader
    cattr_accessor :current_user

    def find_children
        if(current_user.role == "Parent")
            User.all.select{ |u| u.relative_id == current_user.id }
        end
    end

    #0 is checking 1 is savings
    def get_children_accounts
        current_user.find_children.map{ |c| [c.get_accounts(c)[0], c.get_accounts(c)[1]]}.flatten
    end

    def get_accounts(user)
        if(current_user.role != nil)
            Account.all.select{ |a| a.user_id == self.id }
        end
    end

    def get_transactions
        Transaction.all.where{ |t| self.get_accounts(self).include?(t.to_account) or self.get_accounts(self).include?(t.from_account) }
    end

    def get_children_transactions
        final_arr = []
        self.find_children.each do |child|
            final_arr.append(child.get_transactions)
        end
        return final_arr.flatten
    end

    def name
        self.first_name + " " +  self.last_name
    end

    after_create :create_accounts

    #callback
    def create_accounts
        Account.create(user: self, name: "Default Checking Account", interest_rate: 0, balance: 0, account_type: "checking")
        Account.create(user: self, name: "Default Savings Account", interest_rate: 5, balance: 0, account_type: "savings")
    end


    # login by username
    def self.authenticate(username, password)
        find_by_username(username).try(:authenticate, password)
    end
end
