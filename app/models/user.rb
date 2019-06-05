class User < ApplicationRecord
    has_secure_password

    # login by username
    def self.authenticate(username, password)
        find_by_username(username).try(:authenticate, password)
    end
end
