json.extract! todo, :id, :account_id, :step_id, :name, :sequence, :todo_status_id, :description, :notes, :created_at, :updated_at
json.url todo_url(todo, format: :json)
