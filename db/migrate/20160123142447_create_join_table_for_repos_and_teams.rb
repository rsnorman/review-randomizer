class CreateJoinTableForReposAndTeams < ActiveRecord::Migration
  def change
    create_join_table :repos, :teams do |t|
      t.index :repo_id
      t.index :team_id
    end
  end
end
