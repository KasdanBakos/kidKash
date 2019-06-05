class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :name
      t.string :description
      t.references :user, foreign_key: true
      t.datetime :created_at
      t.date :due_at
      t.boolean :completed
      t.float :amount

      t.timestamps
    end
  end
end
