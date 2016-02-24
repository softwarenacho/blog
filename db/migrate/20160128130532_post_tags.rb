class PostTags < ActiveRecord::Migration
  def change
    create_table :posts_tags do |p|
      p.integer :posts_id
      p.integer :tags_id
    end
  end
end
