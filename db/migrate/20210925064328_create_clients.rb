class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email, null: false
      t.string :password, null: false
      t.string :phone, null: false
      t.string :uuid
      t.string :access_token
      t.string :refresh_token
      t.integer :client_id

      t.timestamps
    end

    add_index :clients, :email, unique: true
    add_index :clients, :phone, unique: true
    add_index :clients, :uuid, unique: true
    add_index :clients, :access_token, unique: true
    add_index :clients, :refresh_token, unique: true
    add_index :clients, :client_id, unique: true
  end
end
