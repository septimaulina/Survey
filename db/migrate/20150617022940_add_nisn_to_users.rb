class AddNisnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nisn, :string
    add_index :users, :nisn, unique: true
  end
end
