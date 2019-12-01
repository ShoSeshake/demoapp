class CreateSchoolsMerits < ActiveRecord::Migration[5.2]
  def change
    create_table :schools_merits do |t|
      t.references :school, null: false,index: true, foreign_key: true
      t.references :merit, null: false,index: true, foreign_key: true
      t.timestamps
    end
  end
end
