class RenameColumnPublicToPublicProfile < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :public, :public_profile
  end
end
