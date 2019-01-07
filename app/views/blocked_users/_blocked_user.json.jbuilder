json.extract! blocked_user, :id, :user_id, :created_at, :updated_at
json.url blocked_user_url(blocked_user, format: :json)
