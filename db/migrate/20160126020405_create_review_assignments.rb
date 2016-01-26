class CreateReviewAssignments < ActiveRecord::Migration
  def change
    create_table :review_assignments do |t|
      t.references :pull_request, index: true, foreign_key: true
      t.references :team_membership, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
