class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.string :external_id, limit: 30, null: false
      t.string :url, limit: 2_084, null: false

      t.timestamps null: false
    end

    add_index :gifs, :external_id, unique: true
  end
end
