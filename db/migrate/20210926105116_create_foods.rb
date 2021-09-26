class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :foods, :name, unique: true
  end
end
