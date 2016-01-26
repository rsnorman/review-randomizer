class AddAuthorToPullRequest < ActiveRecord::Migration
  def change
    add_column :pull_requests, :author_id, :integer
    add_foreign_key :pull_requests, :users, column: :author_id
    add_index :pull_requests, :author_id
  end
end
