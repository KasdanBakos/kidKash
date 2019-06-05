class Transaction < ApplicationRecord
  belongs_to :to_account, :class_name => "Account"
  belongs_to :from_account, :class_name => "Account"
end