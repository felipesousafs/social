class CreateFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :followers do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :followers, :follower, foreign_key: {to_table: :users}
  end
end
