class AddOwnerToRepo < ActiveRecord::Migration
  def change
    add_column :repos, :owner_id, :integer
    add_foreign_key :repos, :users, column: :owner_id
    add_index :repos, :owner_id
  end
end
