json.extract! job, :id, :account_id, :name, :sequence, :description, :notes, :created_at, :updated_at
json.url job_url(job, format: :json)
