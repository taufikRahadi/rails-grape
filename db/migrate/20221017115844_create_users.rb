class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true, null: false
      t.string :fullname, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end
