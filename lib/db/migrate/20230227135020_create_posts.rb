class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title 
      t.text :content 
      t.bigint :author_id, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :posts, :author_id, unique: true
    add_index :posts, :deleted_at, unique: true
  end
end
