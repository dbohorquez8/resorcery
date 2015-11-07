class CreateResourceGroups < ActiveRecord::Migration
  def change
    create_table :resource_groups do |t|
      t.string :name
      t.integer :workspace_id
      t.hstore :metadata, default: '', null: false

      t.index :workspace_id
      t.timestamps null: false
    end
  end
end
