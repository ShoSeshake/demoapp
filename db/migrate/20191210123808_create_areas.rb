class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.string     :name,        null: false,   index: true
      t.text       :description, null: false
      t.string     :image
      t.string     :ancestry,    index: true
      t.timestamps
    end
  end
end
