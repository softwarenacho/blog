class PostsTags < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :tags
  belongs_to :posts
end