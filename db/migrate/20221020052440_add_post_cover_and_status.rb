class AddPostCoverAndStatus < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :cover, :string, null: true, :after => 'body'
    add_column :posts, :status, :string, null: false, default: 'draft'
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
