class Thumb < ActiveRecord::Base
  DEFAULT_WIDTH = 300

  def self.generate(dragonfly_job)
    dragonfly_job.thumb("#{Thumb::DEFAULT_WIDTH}x").encode('jpg', '-quality 90')
  end

  # Delete record in thumbs table and delete thumb on s3
  def self.delete(dragonfly_job)
    thumb = Thumb.find_by_signature(dragonfly_job.signature)
    if thumb
      Dragonfly.app.datastore.destroy(thumb.uid)
      thumb.destroy!
    end
  end
end
