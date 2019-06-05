json.extract! account, :id, :user_id, :name, :interest_rate, :balance, :type, :created_at, :updated_at
json.url account_url(account, format: :json)
