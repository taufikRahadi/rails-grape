class CreateActivityLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_logs do |t|
      t.string :user_id, null: true
      t.string :req_ip, null: true
      t.string :user_agent, null: true
      t.string :activity, null: false
      t.timestamps
    end
  end
end
