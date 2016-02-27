class ChangecolumnnameInactive < ActiveRecord::Migration
  def change
  	rename_column :inactive_requests, :user_id, :instructor_id
  end
end
