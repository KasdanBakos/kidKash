class Account < ApplicationRecord
  belongs_to :user

  def get_user
    User.all.select{ |u| u.id == self.user_id }
  end
end
