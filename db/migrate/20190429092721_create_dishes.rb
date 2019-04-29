class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false, unique: true
      t.string :details
      t.boolean :public, default: true
      t.timestamps null: false
    end
  end
end
