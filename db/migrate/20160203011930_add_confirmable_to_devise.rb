class AddConfirmableToDevise < ActiveRecord::Migration
  class MigrationUser < ActiveRecord::Base
    self.table_name = :users
  end

  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_index :users, :confirmation_token, unique: true
    MigrationUser.update_all(confirmed_at: Time.current)
  end

  def down
    remove_columns(
      :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
    )
  end
end
