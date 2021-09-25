class CreateUserClients < ActiveRecord::Migration[6.1]
  def change
    create_table :user_clients do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
