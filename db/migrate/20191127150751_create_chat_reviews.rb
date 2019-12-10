class CreateChatReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_reviews do |t|
      t.integer     :score, null: false
      t.text        :text, null: false
      t.references :chat,      null: false,index: true, foreign_key: true
      t.references :user,      null: false,index: true,  foreign_key: {to_table: :users}
      t.references :reviewee, null: false,index: true,   foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
