class ChangePrAuthorPolymorphic < ActiveRecord::Migration
  def change
    add_column :pull_requests, :author_type, :string, default: 'User'
  end
end
