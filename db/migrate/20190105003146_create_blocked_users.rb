class CreateBlockedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :blocked_users do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :blocked_users, :blocked, foreign_key: {to_table: :users}
  end
end
