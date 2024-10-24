# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Users
user1 = User.create(username: "alice")
user2 = User.create(username: "bob")

# Create Posts
post1 = user1.posts.create(content: "Hello, this is Alice's first post!")
post2 = user2.posts.create(content: "Hi, Bob here. Excited to join!")

# Create Comments
post1.comments.create(user: user2, content: "Welcome Alice!")
post2.comments.create(user: user1, content: "Glad to have you, Bob!")
