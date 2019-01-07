json.extract! reaction, :id, :post_id, :user_id, :reaction_type_id, :created_at, :updated_at
json.url reaction_url(reaction, format: :json)
