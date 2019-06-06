class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :description
      t.string :trans_type
      t.integer :to_account
      t.integer :from_account
      t.datetime :date

      t.timestamps
    end
  end
end
