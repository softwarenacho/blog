class Posts < ActiveRecord::Migration
  def change
    create_table :posts do |p|
      p.integer :users_id
      p.string :content
      p.string :title
 
      p.timestamps
    end
  end
end
