class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.text :description, limit: 500, null: false
      t.date :starts_at, null: false
      t.date :ends_at
      t.integer :status, null: false, default: 0
      t.boolean :premium

      t.timestamps
    end
    add_index :offers, :title, unique: true
  end
end
