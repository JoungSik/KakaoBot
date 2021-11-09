class ChangeContentType < ActiveRecord::Migration[6.1]
  def change
    change_column :notices, :content, :text
  end
end
