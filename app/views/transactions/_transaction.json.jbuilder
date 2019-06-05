json.extract! transaction, :id, :amount, :description, :type, :to_account_id, :from_account_id, :date, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
