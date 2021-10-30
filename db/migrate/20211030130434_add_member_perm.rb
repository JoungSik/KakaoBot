class AddMemberPerm < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :perm, :string, null: false, default: 'NONE'
  end
end
