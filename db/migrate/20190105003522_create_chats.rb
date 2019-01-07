class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_reference :chats, :friend, foreign_key: {to_table: :users}
  end
end
