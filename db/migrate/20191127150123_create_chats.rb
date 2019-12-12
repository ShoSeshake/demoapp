class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.string :user_peer_id
      t.datetime :start_at, null: false
      t.references :adviser, null: false,index: true, foreign_key: {to_table: :users}
      t.references :user, null: false,index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
