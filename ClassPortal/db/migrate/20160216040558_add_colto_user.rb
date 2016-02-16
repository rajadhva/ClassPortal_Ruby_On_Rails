class AddColtoUser < ActiveRecord::Migration
  def change
  	 add_column :users, :super, :boolean, :default => false
  	  add_column :users, :admin, :boolean, :default => false
  	   add_column :users, :instructor, :boolean, :default => false
  	    add_column :users, :student, :boolean, :default => true
  end
end
