class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, :limit => 50, :null => false
      t.string :password_digest, :null => false, :limit => 100
      t.string :type
      t.timestamps null: false
    end
  end
end
