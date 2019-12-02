class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.boolean   :availability,  default: false
      t.integer   :day,          null: false
      t.time      :start_time
      t.time      :end_time
      t.references :user,        null: false,index: true, foreign_key: true
      t.timestamps
    end
  end
end
