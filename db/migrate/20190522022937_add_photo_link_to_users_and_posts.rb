class AddPhotoLinkToUsersAndPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :photo_link, :string
    add_column :posts, :photo_link, :string
  end
end
