class RenameUserFirstNameAndLastNameColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :firstname, :first_name
    rename_column :users, :lastname, :last_name
  end
end
