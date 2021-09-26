class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name, null: false
      t.string :channel_id, null: false
      t.string :channel_type, null: false
      t.text :notice, default: ""

      t.timestamps
    end

    add_index :rooms, :name, unique: true
    add_index :rooms, :channel_id, unique: true
  end
end
