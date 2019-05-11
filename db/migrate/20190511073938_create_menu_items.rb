class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.references :user, foreign_key: true
      t.references :dish, foreign_key: true
      t.string :day, null: false
      t.string :meal, null: false

      t.timestamps null: false
    end
  end
end
