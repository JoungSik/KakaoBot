class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.references :room, null: false, foreign_key: true
      t.string :chat_id, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :members, :chat_id, :unique => true
    add_index :members, :name
  end
end
