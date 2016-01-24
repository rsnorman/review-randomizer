class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.string :handle

      t.timestamps null: false
    end
  end
end
