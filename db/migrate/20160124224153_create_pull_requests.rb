class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.references :repo, index: true, foreign_key: true
      t.string :title
      t.integer :number

      t.timestamps null: false
    end
  end
end
