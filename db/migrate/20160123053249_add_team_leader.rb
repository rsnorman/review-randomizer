class AddTeamLeader < ActiveRecord::Migration
  def change
    add_column :teams, :leader_id, :integer
    add_foreign_key :teams, :users, column: :leader_id
    add_index :teams, :leader_id
  end
end
