class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.references :user, foreign_key: true
      t.references :dish, foreign_key: true
      t.string :day
      t.string :meal

      t.timestamps null: false
    end
  end
end
