class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.date :start_date
      t.date :end_date

      t.hstore :metadata, default: '', null: false

      t.integer :workspace_id
      t.integer :resource_id
      t.integer :resource_group_id

      t.index [:workspace_id, :resource_id, :resource_group_id], name: "workspace_resource_and_group"
      t.index [:start_date, :end_date]

      t.timestamps null: false
    end
  end
end
