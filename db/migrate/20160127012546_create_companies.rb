class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :token, limit: 36
      t.string :domain

      t.timestamps null: false
    end

    add_column :companies, :owner_id, :integer
    add_foreign_key :companies, :users, column: :owner_id
    add_index :companies, :owner_id
  end
end
