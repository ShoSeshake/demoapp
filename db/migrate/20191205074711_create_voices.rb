class CreateVoices < ActiveRecord::Migration[5.2]
  def change
    create_table :voices do |t|
      t.text :text,              null: false
      t.references :chat,        null: false,index: true, foreign_key: true
      t.references :user,        null: false,index: true, foreign_key: true
      t.timestamps
    end
  end
end
