json.extract! user, :id, :name, :email, :password, :activated, :blocked, :created_at, :updated_at
json.url user_url(user, format: :json)
