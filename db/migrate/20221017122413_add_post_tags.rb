class AddPostTags < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :tags do |t|
      t.index :post_id
      t.index :tag_id
    end
  end
end
