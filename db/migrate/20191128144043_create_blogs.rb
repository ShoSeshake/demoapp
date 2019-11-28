class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.references :user, null: false,index: true, foreign_key: true
      t.timestamps
    end
  end
end
