class CreateBanKeywords < ActiveRecord::Migration[6.1]
  def change
    create_table :ban_keywords do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :category, default: 0
      t.string :name, null: false
      t.string :word, null: false

      t.timestamps
    end

    add_index :ban_keywords, :category
  end
end
