class CreateSubscribes < ActiveRecord::Migration
  def change
    create_table :subscribes do |t|
      t.string :user
      t.string :course

      t.timestamps null: false
    end
  end
end
