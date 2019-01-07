class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.references :reaction_type, foreign_key: true

      t.timestamps
    end
  end
end
