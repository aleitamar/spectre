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
      acl: 'public-read',
      storge_class: 'REDUCED_REDUNDANCY'
  else
    datastore :file,
      root_path: Rails.root.join('public/system/dragonfly', Rails.env),
      server_root: Rails.root.join('public')
  end

  # Override the .url method...
  define_url do |app, job, opts|
    thumb = Thumb.find_by_signature(job.signature)
    # If (fetch 'some_uid' then resize to '40x40') has been stored already, give the datastore's remote url ...
    if thumb
      app.datastore.url_for(thumb.uid)
    # ...otherwise give the local Dragonfly server url
    else
      app.server.url_for(job)
    end
  end

  # Before serving from the local Dragonfly server...
  before_serve do |job, env|
    # ...store the thumbnail in the datastore...
    begin
      uid = job.store
      # ...keep track of its uid so next time we can serve directly from the datastore
      Thumb.create!(uid: uid, signature: job.signature)
    rescue Dragonfly::Job::Fetch::NotFound => _
      # do nothing, original image was already deleted
    end
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
