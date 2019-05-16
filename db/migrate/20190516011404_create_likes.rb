class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|

      t.belongs_to :liking_user
      t.belongs_to :liked_post
    end
  end
end
