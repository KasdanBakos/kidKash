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

    def get_accounts(user)
        if(current_user.role != nil)
            Account.all.select{ |a| a.user_id == self.id }
        end
    end




    after_create :create_accounts

    #callback
    def create_accounts
        Account.create(user: self, name: "Default Checking Account", interest_rate: 0, balance: 0, account_type: "checking")
        Account.create(user: self, name: "Default Savings Account", interest_rate: 5, balance: 0, account_type: "savings")
    end

    # def parent_account?
    #     return current_user.role == "Parent"
    # end


    # login by username
    def self.authenticate(username, password)
        find_by_username(username).try(:authenticate, password)
    end
end
