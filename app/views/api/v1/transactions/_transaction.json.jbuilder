json.extract! transaction, :id, :transaction_date, :amount, :family_id, :user_id, :category_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
json.receipt_url transaction.receipt.attached? ? url_for(transaction.receipt) : ''
