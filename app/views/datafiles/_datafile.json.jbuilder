json.extract! datafile, :id, :dataset_id, :web_id, :storage_root, :storage_key, :storage_prefix, :filename, :size, :created_at, :updated_at
json.url datafile_url(datafile, format: :json)
