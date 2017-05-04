class Suite < ActiveRecord::Base
  belongs_to :project
  has_many :runs, dependent: :destroy
  has_many :tests, through: :runs, dependent: :destroy
  has_many :baselines, dependent: :destroy
  after_initialize :create_slug

  SPECTRE_RUN_HISTORY_SIZE = ENV.fetch('SPECTRE_RUN_HISTORY_SIZE', 5).to_i

  def latest_run
    runs.order(id: :desc).first
  end

  def create_slug
    self.slug ||= name.to_s.parameterize
  end

  def to_param
    slug
  end

  def purge_old_runs
    self.runs.order(id: :desc).offset(SPECTRE_RUN_HISTORY_SIZE).destroy_all
  end
end
