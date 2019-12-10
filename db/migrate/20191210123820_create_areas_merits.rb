class CreateAreasMerits < ActiveRecord::Migration[5.2]
  def change
    create_table :areas_merits do |t|
      t.references :area,         null: false,index: true, foreign_key: true
      t.references :merit,        null: false,index: true, foreign_key: true
      t.timestamps
    end
  end
end
