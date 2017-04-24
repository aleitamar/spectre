class AddDiffThresholdToTest < ActiveRecord::Migration
  def change
    add_column :tests, :diff_threshold, :float
  end
end
