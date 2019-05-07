class ChangeNickInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :nick, :string, null: false
  end
end
