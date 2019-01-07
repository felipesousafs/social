class CreateStrikes < ActiveRecord::Migration[5.2]
  def change
    create_table :strikes do |t|
      t.text :text
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_reference :strikes, :striker, foreign_key: {to_table: :users}
  end
end
