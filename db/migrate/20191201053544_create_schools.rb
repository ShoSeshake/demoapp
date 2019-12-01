class CreateSchools < ActiveRecord::Migration[5.2]
  def change
    create_table :schools do |t|
      t.string  :name,          null: false
      t.text    :description,   null: false
      t.integer :location,   null: false
      t.timestamps
    end
  end
end
