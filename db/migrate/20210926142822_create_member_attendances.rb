class CreateMemberAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :member_attendances do |t|
      t.references :member, null: false, foreign_key: true
      t.date :due_date, null: false, default: Date.today

      t.timestamps
    end

    add_index :member_attendances, :due_date
  end
end
