class CreateWorkspaces < ActiveRecord::Migration
  def change
    create_table :workspaces do |t|
      t.string :name
      t.hstore :metadata, default: '', null: false

      t.timestamps null: false
    end
  end
end
