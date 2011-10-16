class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :unity_id
       t.integer :utype
      t.timestamps
    end
  end
end
