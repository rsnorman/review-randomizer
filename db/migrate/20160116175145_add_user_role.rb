class AddUserRole < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'User', limit: 5
  end
end
