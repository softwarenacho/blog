class Tags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
    end
  end
end
