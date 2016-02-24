class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts_tags
  has_many :posts, through: :posts_tags
end



# En los controladores 

# @post = Post.find(3)
# @tag = Tag.find_or_create_by(tag: "mex")

# @post.tags << Tag.create(tag: "df")
# @post.tags << @tag 

# @post.save
