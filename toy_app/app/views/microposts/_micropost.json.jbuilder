json.extract! micropost, :id, :contect, :user_id, :created_at, :updated_at
json.url micropost_url(micropost, format: :json)
