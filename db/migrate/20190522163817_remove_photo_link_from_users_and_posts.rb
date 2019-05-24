class RemovePhotoLinkFromUsersAndPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :photo_link, :string
    remove_column :posts, :photo_link, :string
  end
end
