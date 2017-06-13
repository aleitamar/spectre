class AddExternalIdToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :external_id, :string
    add_index :runs, :external_id
  end
end
