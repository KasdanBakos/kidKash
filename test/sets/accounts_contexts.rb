module Contexts
    module AccountContexts
        def create_accounts
            @account1 = FactoryBot.create(:account)
        end

        def destroy_accounts
            @account1.delete
        end