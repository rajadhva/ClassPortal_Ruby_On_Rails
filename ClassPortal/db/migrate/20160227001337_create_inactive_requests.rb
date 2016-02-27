class CreateInactiveRequests < ActiveRecord::Migration
  def change
    create_table :inactive_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.string :Status , :default => "Pending"
      t.timestamps null: false
    end
  end
end
