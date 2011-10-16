class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.string :postName
      t.integer :IDofParent
      # t.references :user
      t.references :user
      t.timestamps
    end
  end
end
