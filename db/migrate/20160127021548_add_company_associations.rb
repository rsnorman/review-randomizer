class AddCompanyAssociations < ActiveRecord::Migration
  def change
    add_column :users, :company_id, :integer
    add_foreign_key :users, :companies
    add_index :users, :company_id

    add_column :teams, :company_id, :integer
    add_foreign_key :teams, :companies
    add_index :teams, :company_id

    add_column :repos, :company_id, :integer
    add_foreign_key :companies, :companies
    add_index :repos, :company_id

    remove_column :repos, :name
  end
end
