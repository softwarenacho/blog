class Users < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :name
      u.string :email
      u.string :pwd
      u.timestamps
    end
  end
end
