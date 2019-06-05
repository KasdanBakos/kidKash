class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.float :interest_rate
      t.float :balance
      t.string :type

      t.timestamps
    end
  end
end
