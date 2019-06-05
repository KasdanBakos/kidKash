class User < ApplicationRecord
    has_secure_password






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
