class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.integer :mood
      t.date    :date
      t.timestamps
    end
  end
end
