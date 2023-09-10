class UpdateUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :activated, :boolean, default: false
    change_column :users, :blocked, :boolean, default: false

    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :password, false
  end
end
