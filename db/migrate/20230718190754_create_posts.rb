class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.timestamps
      t.integer :commentsCounter
      t.integer :likesCounter
    end
  end
end
