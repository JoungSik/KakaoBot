class CreateFortunes < ActiveRecord::Migration[6.1]
  def change
    create_table :fortunes do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.date :due_date, null: false, default: Date.today

      t.timestamps
    end

    add_index :fortunes, :name
    add_index :fortunes, :due_date
  end
end
