class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :description
      t.string :url
      t.references :course

      t.timestamps null: false

    end
  end
end
