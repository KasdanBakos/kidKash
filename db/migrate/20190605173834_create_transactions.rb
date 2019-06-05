class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :description
      t.string :type
      t.references :to_account, foreign_key: true
      t.references :from_account, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
