require './test/sets/account_contexts'


module Contexts 
    include Contexts::AccountContexts

    def create_contexts
        create_accounts
        puts("created accounts")

    end
end