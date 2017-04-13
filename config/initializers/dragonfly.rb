require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "5fc2f8d11fb3d4ad28a4c4e3e353d2ca9e041e14930d48a5c1242613f9cdd2cc"

  url_format "/media/:job/:name"

  if ENV['DRAGONFLY_S3_DATASTORE']
    datastore :s3,
      bucket_name: ENV['DRAGONFLY_S3_BUCKET'],
      region: ENV['DRAGONLY_S3_REGION'],
      url_scheme: ENV['DRAGONLY_S3_URL_SCHEME'] || 'http',
      use_iam_profile: ENV['DRAGONLY_S3_USE_IAM'] == 'true',
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  else
    datastore :file,
      root_path: Rails.root.join('public/system/dragonfly', Rails.env),
      server_root: Rails.root.join('public')
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
