User.create!(email: 'admin@fakebook.com', password: 'password', firstname: "Best", lastname: "Admin", location: "Unknown", age: 1000)
User.create!(email: 'chef@fakebook.com', password: 'password', firstname: "Best", lastname: "Chef", location: "Unknown", age: 39)
User.create!(email: 'sage@fakebook.com', password: 'password', firstname: "Clairvoyant", lastname: "Sage", location: "Yonder", age: 10000)
FriendRequest.create!(sender_id: 2, recipient_id: 1)
Friendship.create!(user_id: 1, friend_id: 3)
Post.create!(user_id: 1, body: "First post!")
Post.create!(user_id: 3, body: "Hello world!")
Post.create!(user_id: 3, body: "I foresaw the creation of this post.")
Like.create!(liking_user_id: 2, liked_post_id: 1)
Comment.create!(user_id: 1, post_id: 1, body: "I just had to say, Hello World!")