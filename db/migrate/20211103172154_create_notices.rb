class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.belongs_to :room, null: false, foreign_key: true
      t.string :category, null: false
      t.string :content, null: false

      t.timestamps
    end

    remove_columns :rooms, :notice
  end
end
