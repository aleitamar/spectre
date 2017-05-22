class Thumb
  DEFAULT_WIDTH = 300

  def self.create(dragonfly_job)
    dragonfly_job.thumb("#{Thumb::DEFAULT_WIDTH}x").encode('jpg', '-quality 90')
  end
end
