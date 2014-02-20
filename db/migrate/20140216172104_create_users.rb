class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :username, :string, :null => false
      t.column :email, :string, :null => false
      t.column :password, :string, :null => false
      t.column :is_superuser, :boolean, :default => false
      t.timestamps
    end
  end
end
